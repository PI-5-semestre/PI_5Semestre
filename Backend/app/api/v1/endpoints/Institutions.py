from http import HTTPStatus
from typing import Annotated, Optional, List, Union
from io import BytesIO

from fastapi import APIRouter, Depends, Query, UploadFile, File, Form
from fastapi.responses import StreamingResponse
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.database import get_session
from app.core.security import get_current_account
from app.core.settings import Settings
from app.core.exceptions import DuplicatedError, NotFoundError, AlreadyExistsError
from app.api.v1.dependencies import PaginationParams
from app.models.users import Account, AccountType
from app.util.file_validation import validate_file_upload
from app.schemas.Institutions import (
    DeliveryCreate,
    DeliveryPut,
    DeliveryResp,
    InstitutionUpdate,
    InstitutionResp,
)
from app.schemas.products import (
    StockItemResp,
    StockItemCreateForInstitution,
    StockItemUpdate,
    StockHistoryResp,
)
from app.schemas.families import (
    FamilyResp,
    FamilyCreateForInstitution,
    FamilyUpdate,
    DocFamilyResp,
)
from app.models.Institutions import Institution, InstitutionType
from app.models.products import StockItem, StockHistory
from app.models.families import Family, DocFamily, FamilyDelivery, SituationType

router = APIRouter(prefix="/institutions", tags=["institutions"])
Session = Annotated[AsyncSession, Depends(get_session)]

settings = Settings()


async def get_institution_or_404(
    session: AsyncSession, institution_id: int
) -> Institution:
    result = await session.execute(
        select(Institution).where(Institution.id == institution_id)
    )
    institution = result.scalar_one_or_none()

    if institution is None:
        raise NotFoundError(detail=f"Institution with id {institution_id} not found")

    return institution


async def get_family_or_404(
    session: AsyncSession, identifier: Union[int, str], institution_id: int
) -> Family:
    if isinstance(identifier, int):
        query = select(Family).where(
            Family.id == identifier, Family.institution_id == institution_id
        )
    else:
        normalized_cpf = identifier.replace(".", "").replace("-", "")
        query = select(Family).where(
            Family.cpf == normalized_cpf, Family.institution_id == institution_id
        )
    
    result = await session.execute(query)
    family = result.scalar_one_or_none()

    if family is None:
        raise NotFoundError(
            detail=f"Family with identifier '{identifier}' not found in this institution"
        )

    return family

async def get_account_or_404(
    session: AsyncSession, account_id: int
) -> Account:
    result = await session.execute(
        select(Account).where(Account.id == account_id)
    )
    account = result.scalar_one_or_none()

    if account is None:
        raise NotFoundError(detail=f"Account with id {account_id} not found")

    return account


async def get_stock_item_or_404(
    session: AsyncSession, sku: str, institution_id: int
) -> StockItem:
    result = await session.execute(
        select(StockItem).where(
            StockItem.sku == sku.upper(), StockItem.institution_id == institution_id
        )
    )
    product = result.scalar_one_or_none()

    if product is None:
        raise NotFoundError(
            detail=f"Product with SKU '{sku}' not found in this institution"
        )

    return product


@router.get("/", response_model=list[InstitutionResp])
async def list_institutions(
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: Optional[bool] = Query(None),
    institution_type: Optional[str] = Query(None),
):
    query = select(Institution)

    if active is not None:
        query = query.where(Institution.active == active)

    if institution_type is not None:
        try:
            inst_type = InstitutionType[institution_type.upper()]
            query = query.where(Institution.institution_type == inst_type)
        except (ValueError, KeyError):
            raise NotFoundError(detail=f"Invalid institution type: {institution_type}")

    query = (
        query.order_by(Institution.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    institutions = result.scalars().all()

    return [InstitutionResp.model_validate(inst) for inst in institutions]


@router.get("/{institution_id}", response_model=InstitutionResp)
async def get_institution(institution_id: int, session: Session):
    institution = await get_institution_or_404(session, institution_id)
    return InstitutionResp.model_validate(institution)


@router.put("/{institution_id}", response_model=InstitutionResp)
async def update_institution(
    institution_id: int, payload: InstitutionUpdate, session: Session
):
    try:
        institution = await get_institution_or_404(session, institution_id)

        if payload.name is not None:
            institution.name = payload.name

        if payload.institution_type is not None:
            try:
                institution.institution_type = InstitutionType[
                    payload.institution_type.upper()
                ]
            except (ValueError, KeyError):
                raise NotFoundError(
                    detail=f"Invalid institution type: {payload.institution_type}"
                )

        await session.commit()
        await session.refresh(institution)

        return InstitutionResp.model_validate(institution)

    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Institution name already in use")

    except NotFoundError:
        raise

    except Exception:
        await session.rollback()
        raise


@router.delete("/{institution_id}", status_code=HTTPStatus.NO_CONTENT)
async def delete_institution(institution_id: int, session: Session):
    institution = await get_institution_or_404(session, institution_id)
    institution.active = False

    try:
        await session.commit()
    except Exception:
        await session.rollback()
        raise

    return None


@router.get("/{institution_id}/stock", response_model=list[StockItemResp])
async def get_institution_stock(
    institution_id: int,
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: Optional[bool] = Query(None),
    search: Optional[str] = Query(None),
):
    await get_institution_or_404(session, institution_id)

    query = select(StockItem).where(StockItem.institution_id == institution_id)

    if active is not None:
        query = query.where(StockItem.active == active)

    if search is not None:
        search_pattern = f"%{search.strip()}%"
        query = query.where(
            (StockItem.name.ilike(search_pattern))
            | (StockItem.sku.ilike(search_pattern))
        )

    query = (
        query.order_by(StockItem.name)
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    stock_items = result.scalars().all()

    return [StockItemResp.model_validate(item) for item in stock_items]


@router.post(
    "/{institution_id}/stock",
    response_model=StockItemResp,
    status_code=HTTPStatus.CREATED,
)
async def add_stock_item_to_institution(
    institution_id: int, payload: StockItemCreateForInstitution, session: Session
):
    await get_institution_or_404(session, institution_id)

    try:
        stock_item = StockItem(
            institution_id=institution_id,
            name=payload.name,
            sku=payload.sku,
            quantity=payload.quantity,
        )
        session.add(stock_item)
        await session.commit()
        await session.refresh(stock_item)

        return StockItemResp.model_validate(stock_item)

    except IntegrityError as e:
        await session.rollback()
        error_msg = str(e.orig).lower()

        if "sku" in error_msg or "idx_stock_sku_institution" in error_msg:
            raise DuplicatedError(
                detail=f"Product with SKU '{payload.sku}' already exists in this institution"
            )

        raise DuplicatedError(detail="Duplicate entry")

    except Exception:
        await session.rollback()
        raise


@router.get("/{institution_id}/stock/summary")
async def get_institution_stock_summary(institution_id: int, session: Session):
    await get_institution_or_404(session, institution_id)

    from sqlalchemy import func

    total_items_query = select(func.count(StockItem.id)).where(
        StockItem.institution_id == institution_id, StockItem.active == True
    )
    total_items_result = await session.execute(total_items_query)
    total_items = total_items_result.scalar()

    total_quantity_query = select(func.sum(StockItem.quantity)).where(
        StockItem.institution_id == institution_id, StockItem.active == True
    )
    total_quantity_result = await session.execute(total_quantity_query)
    total_quantity = total_quantity_result.scalar() or 0

    low_stock_query = select(func.count(StockItem.id)).where(
        StockItem.institution_id == institution_id,
        StockItem.active == True,
        StockItem.quantity < 10,
    )
    low_stock_result = await session.execute(low_stock_query)
    low_stock_items = low_stock_result.scalar()

    out_of_stock_query = select(func.count(StockItem.id)).where(
        StockItem.institution_id == institution_id,
        StockItem.active == True,
        StockItem.quantity == 0,
    )
    out_of_stock_result = await session.execute(out_of_stock_query)
    out_of_stock_items = out_of_stock_result.scalar()

    return {
        "institution_id": institution_id,
        "total_items": total_items,
        "total_quantity": total_quantity,
        "low_stock_items": low_stock_items,
        "out_of_stock_items": out_of_stock_items,
    }


@router.get("/{institution_id}/stock/{sku}", response_model=StockItemResp)
async def get_institution_stock_item(institution_id: int, sku: str, session: Session):
    await get_institution_or_404(session, institution_id)
    product = await get_stock_item_or_404(session, sku, institution_id)
    return StockItemResp.model_validate(product)


@router.put("/{institution_id}/stock/{sku}", response_model=StockItemResp)
async def update_institution_stock_item(
    institution_id: int, sku: str, payload: StockItemUpdate, session: Session
):
    try:
        await get_institution_or_404(session, institution_id)
        product = await get_stock_item_or_404(session, sku, institution_id)

        if payload.name is not None:
            product.name = payload.name

        if payload.quantity is not None:
            quantity_change = payload.quantity - product.quantity
            product.quantity = payload.quantity

            if quantity_change != 0:
                history = StockHistory(
                    stock_item_id=product.id, quantity=quantity_change
                )
                session.add(history)

        await session.commit()
        await session.refresh(product)

        return StockItemResp.model_validate(product)

    except NotFoundError:
        raise

    except Exception:
        await session.rollback()
        raise


@router.delete("/{institution_id}/stock/{sku}", status_code=HTTPStatus.NO_CONTENT)
async def delete_institution_stock_item(
    institution_id: int, sku: str, session: Session
):
    await get_institution_or_404(session, institution_id)
    product = await get_stock_item_or_404(session, sku, institution_id)

    try:
        history = StockHistory(stock_item_id=product.id, quantity=-product.quantity)
        session.add(history)
        await session.flush()

        await session.delete(product)
        await session.commit()
    except Exception:
        await session.rollback()
        raise

    return None


@router.get(
    "/{institution_id}/stock/{sku}/history", response_model=list[StockHistoryResp]
)
async def get_institution_stock_item_history(
    institution_id: int,
    sku: str,
    session: Session,
    pagination: dict = Depends(PaginationParams),
):
    await get_institution_or_404(session, institution_id)
    product = await get_stock_item_or_404(session, sku, institution_id)

    query = (
        select(StockHistory)
        .where(StockHistory.stock_item_id == product.id)
        .order_by(StockHistory.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    history = result.scalars().all()

    return [StockHistoryResp.model_validate(h) for h in history]


@router.post("/{institution_id}/families", response_model=FamilyResp, status_code=201)
async def create_family_for_institution(
    institution_id: int, family_data: FamilyCreateForInstitution, session: Session
):
    await get_institution_or_404(session, institution_id)

    cpf_check = await session.execute(
        select(Family).where(Family.cpf == family_data.cpf)
    )
    if cpf_check.scalar_one_or_none():
        raise AlreadyExistsError(
            detail=f"Family with CPF '{family_data.cpf}' already exists"
        )

    new_family = Family(**family_data.model_dump(), institution_id=institution_id)

    session.add(new_family)
    await session.commit()
    await session.refresh(new_family)

    return FamilyResp.model_validate(new_family)


@router.get("/{institution_id}/families", response_model=List[FamilyResp])
async def list_families_from_institution(
    institution_id: int,
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: bool | None = None,
    situation: SituationType | None = None,
):
    await get_institution_or_404(session, institution_id)

    query = (
        select(Family)
        .where(Family.institution_id == institution_id)
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    if active is not None:
        query = query.where(Family.active == active)

    if situation:
        query = query.where(Family.situation == situation)

    result = await session.execute(query)
    families = result.scalars().all()

    return [FamilyResp.model_validate(f) for f in families]


@router.get("/{institution_id}/families/{cpf}", response_model=FamilyResp)
async def get_family_from_institution(institution_id: int, cpf: str, session: Session):
    await get_institution_or_404(session, institution_id)

    normalized_cpf = cpf.replace(".", "").replace("-", "")

    query = (
        select(Family)
        .options(selectinload(Family.documents))
        .where(Family.cpf == normalized_cpf, Family.institution_id == institution_id)
    )
    result = await session.execute(query)
    family = result.scalar_one_or_none()

    if family is None:
        raise NotFoundError(
            detail=f"Family with CPF '{cpf}' not found in this institution"
        )

    return FamilyResp.model_validate(family)


@router.put("/{institution_id}/families/{cpf}", response_model=FamilyResp)
async def update_family_from_institution(
    institution_id: int, cpf: str, family_data: FamilyUpdate, session: Session
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    for field, value in family_data.model_dump(exclude_unset=True).items():
        setattr(family, field, value)

    await session.commit()
    await session.refresh(family)

    return FamilyResp.model_validate(family)


@router.delete("/{institution_id}/families/{cpf}", status_code=204)
async def delete_family_from_institution(
    institution_id: int, cpf: str, session: Session
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    family.active = False
    await session.commit()


@router.post(
    "/{institution_id}/families/{cpf}/documents",
    response_model=DocFamilyResp,
    status_code=201,
)
async def upload_family_document(
    institution_id: int,
    cpf: str,
    session: Session,
    doc_type: str = Form(...),
    file: UploadFile = File(...),
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    file_content = await validate_file_upload(file)

    new_doc = DocFamily(
        doc_type=doc_type.upper(),
        doc_file=file_content,
        file_name=file.filename,
        mime_type=file.content_type,
        family_id=family.id,
    )

    session.add(new_doc)
    await session.commit()
    await session.refresh(new_doc)

    return DocFamilyResp.model_validate(new_doc)


@router.get(
    "/{institution_id}/families/{cpf}/documents", response_model=List[DocFamilyResp]
)
async def list_family_documents(institution_id: int, cpf: str, session: Session):
    await get_institution_or_404(session, institution_id)

    normalized_cpf = cpf.replace(".", "").replace("-", "")

    query = (
        select(Family)
        .options(selectinload(Family.documents))
        .where(Family.cpf == normalized_cpf, Family.institution_id == institution_id)
    )
    result = await session.execute(query)
    family = result.scalar_one_or_none()

    if family is None:
        raise NotFoundError(
            detail=f"Family with CPF '{cpf}' not found in this institution"
        )

    return [DocFamilyResp.model_validate(doc) for doc in family.documents]


@router.get("/{institution_id}/families/{cpf}/documents/{doc_id}/download")
async def download_family_document(
    institution_id: int, cpf: str, doc_id: int, session: Session
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    query = select(DocFamily).where(
        DocFamily.id == doc_id, DocFamily.family_id == family.id
    )
    result = await session.execute(query)
    document = result.scalar_one_or_none()

    if document is None:
        raise NotFoundError(
            detail=f"Document with id {doc_id} not found for this family"
        )

    file_stream = BytesIO(document.doc_file)

    return StreamingResponse(
        file_stream,
        media_type=document.mime_type,
        headers={"Content-Disposition": f"attachment; filename={document.file_name}"},
    )


@router.delete("/{institution_id}/families/{cpf}/documents/{doc_id}", status_code=204)
async def delete_family_document(
    institution_id: int, cpf: str, doc_id: int, session: Session
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    query = select(DocFamily).where(
        DocFamily.id == doc_id, DocFamily.family_id == family.id
    )
    result = await session.execute(query)
    document = result.scalar_one_or_none()

    if document is None:
        raise NotFoundError(
            detail=f"Document with id {doc_id} not found for this family"
        )

    await session.delete(document)
    await session.commit()


@router.get("/{institution_id}/deliveries", response_model=List[DeliveryResp])
async def list_family_deliveries(
    institution_id: int,
    current_account: Annotated[Account, Depends(get_current_account)],
    session: Session,
    pagination: dict = Depends(PaginationParams),
):
    await get_institution_or_404(session, institution_id)

    if current_account.account_type not in [
        AccountType.ADMINISTRATIVE,
        AccountType.OWNER,
    ]:
        raise NotFoundError(detail="Unauthorized to create deliveries")

    query = select(FamilyDelivery).where(
        FamilyDelivery.institution_id == institution_id
    )

    query = (
        query.order_by(FamilyDelivery.delivery_date.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    deliveries = result.scalars().all()

    return [DeliveryResp.model_validate(d) for d in deliveries]


@router.post(
    "/{institution_id}/deliveries",
    response_model=DeliveryResp,
    status_code=201,
)
async def create_family_delivery(
    institution_id: int,
    payload: DeliveryCreate,
    session: Session,
    current_account: Annotated[Account, Depends(get_current_account)],
):
    institution = await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, payload.family_id, institution_id)
    account = await get_account_or_404(session, payload.account_id)

    if current_account.account_type not in [
        AccountType.ADMINISTRATIVE,
        AccountType.OWNER,
    ]:
        raise NotFoundError(detail="Unauthorized to create deliveries")

    fd = FamilyDelivery(
        institution_id=institution.id,
        family_id=family.id,
        delivery_date=payload.date.isoformat(),
        account_id=account.id,
        description=payload.description,
    )
    session.add(fd)
    await session.commit()
    await session.refresh(fd)

    return DeliveryResp.model_validate(fd)


@router.put("/{institution_id}/deliveries/{delivery_id}", response_model=DeliveryResp)
async def update_family_delivery(
    institution_id: int,
    current_account: Annotated[Account, Depends(get_current_account)],
    delivery_id: int,
    payload: DeliveryPut,
    session: Session,
):
    await get_institution_or_404(session, institution_id)
    account = await get_account_or_404(session, payload.account_id)

    if current_account.account_type not in [
        AccountType.ADMINISTRATIVE,
        AccountType.OWNER,
    ]:
        raise NotFoundError(detail="Unauthorized to create deliveries")

    result = await session.execute(
        select(FamilyDelivery).where(
            FamilyDelivery.id == delivery_id,
            FamilyDelivery.institution_id == institution_id,
        )
    )
    delivery = result.scalar_one_or_none()

    if delivery is None:
        raise NotFoundError(
            detail=f"Delivery with id {delivery_id} not found in this institution"
        )

    delivery.delivery_date = payload.date.isoformat()
    delivery.account_id = account.id
    delivery.description = payload.description

    await session.commit()
    await session.refresh(delivery)

    return DeliveryResp.model_validate(delivery)


@router.delete("/{institution_id}/deliveries/{delivery_id}", status_code=204)
async def delete_family_delivery(
    institution_id: int,
    current_account: Annotated[Account, Depends(get_current_account)],
    delivery_id: int,
    session: Session,
):
    await get_institution_or_404(session, institution_id)

    if current_account.account_type not in [
        AccountType.ADMINISTRATIVE,
        AccountType.OWNER,
    ]:
        raise NotFoundError(detail="Unauthorized to create deliveries")

    result = await session.execute(
        select(FamilyDelivery).where(
            FamilyDelivery.id == delivery_id,
            FamilyDelivery.institution_id == institution_id,
        )
    )
    delivery = result.scalar_one_or_none()

    if delivery is None:
        raise NotFoundError(
            detail=f"Delivery with id {delivery_id} not found in this institution"
        )

    delivery.active = False

    await session.flush()
    await session.commit()

    return None
