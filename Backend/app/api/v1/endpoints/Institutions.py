from http import HTTPStatus
from fastapi import HTTPException
from typing import Annotated, Any, Optional, List, Union
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
    DeliveryReschedule,
    DeliveryResp,
    InstitutionUpdate,
    InstitutionResp,
    UserCorporateResp,
    VisitationCreate,
    VisitationCreateReturn,
    VisitationResp,
    VisitationResponseReturn,
)
from app.schemas.products import (
    StockItemResp,
    StockItemCreateForInstitution,
    StockItemUpdate,
    StockHistoryResp,
    StockItemUpdateQuantity,
)
from app.schemas.families import (
    FamilyResp,
    FamilyCreateForInstitution,
    FamilyUpdate,
    DocFamilyResp,
)
from app.models.Institutions import Institution, InstitutionType, InstitutionVisitation, InstitutionVisitationResult, InstitutionVisitationResultType, InstitutionVisitationType
from app.models.products import StockItem, StockHistory
from app.models.families import DeliveryAttempt, DeliveryAttemptStatus, Family, DocFamily, FamilyDelivery, FamilyMember, SituationDelivery, SituationType

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

async def get_item_or_404(
    session: AsyncSession, sku: str, institution_id: int,
) -> Any:
    result = await session.execute(
        select(StockItem).where(
            StockItem.sku == sku.upper(), StockItem.institution_id == institution_id
        )
    )
    item = result.scalar_one_or_none()

    if item is None:
        raise NotFoundError(detail=f"StockItem with SKU {sku} not found in institution {institution_id}")

    return item


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
            quantity=0,
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
    
@router.post("/{institution_id}/stock/control", status_code=HTTPStatus.CREATED)
async def control_stock_to_institution(
    institution_id: int, payload: List[StockItemUpdateQuantity], session: Session
):
    await get_institution_or_404(session, institution_id)
    try:
        for item_data in payload:
            item = await get_item_or_404(session, sku=item_data.sku, institution_id=institution_id)
            
            if item.quantity + item_data.quantity < 0:
                raise HTTPException(
                    status_code=HTTPStatus.BAD_REQUEST,
                    detail=f"Insufficient stock for SKU '{item_data.sku}' in institution {institution_id}",
                )
        
            item.quantity += item_data.quantity
            session.add(item)
            
            history = StockHistory(
                    stock_item_id=item.id, quantity=item_data.quantity
                )
            session.add(history)

        await session.commit()
    except NotFoundError:
        raise

    except Exception:
        await session.rollback()
        raise
    
    
# @router.post("/{institution_id}/basket", status_code=HTTPStatus.CREATED)
# async def create_basket_for_institution(
#     institution_id: int, session: Session
# ):
#     await get_institution_or_404(session, institution_id)
    
#     return {"detail": "Basket creation not yet implemented"}


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
    institution_id: int, family_data: FamilyCreateForInstitution, session: Session, current_account: Annotated[Account, Depends(get_current_account)],
):
    await get_institution_or_404(session, institution_id)

    cpf_check = await session.execute(
        select(Family).where(Family.cpf == family_data.cpf)
    )
    if cpf_check.scalar_one_or_none():
        raise AlreadyExistsError(
            detail=f"Family with CPF '{family_data.cpf}' already exists"
        )

    try:
        new_family = Family(**family_data.model_dump(), institution_id=institution_id)

        session.add(new_family)
        await session.commit()
        await session.refresh(new_family)

        return FamilyResp.model_validate(new_family)
    except IntegrityError as e:
        await session.rollback()
        error_msg = str(e.orig).lower()
        if "cpf" in error_msg:
             raise DuplicatedError(detail="Family with this CPF already exists.")
        raise


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
async def get_family_from_institution(institution_id: int, cpf: str, session: Session, current_account: Annotated[Account, Depends(get_current_account)]):
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
    institution_id: int,
    cpf: str,
    family_data: FamilyUpdate,
    session: Session,
    current_account: Annotated[Account, Depends(get_current_account)],
):
    await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, cpf, institution_id)

    try:
        for field, value in family_data.model_dump(exclude_unset=True).items():
            if field == "members":               
                for member_data in value:
                    if 'cpf' in member_data and member_data['cpf']:
                        member_data['cpf'] = member_data['cpf'].replace(".", "").replace("-", "")
                    
                    member_id = member_data.get('id')
                    cpf = member_data.get('cpf')
                    existing_member = None

                    if member_id:
                        for m in family.members:
                            if m.id == member_id:
                                existing_member = m
                                break

                    if not existing_member and cpf:
                        for m in family.members:
                            if m.cpf == cpf:
                                existing_member = m
                                break
                    
                    if existing_member:
                        if 'cpf' in member_data:
                            existing_member.cpf = member_data['cpf']
                        if 'name' in member_data:
                            existing_member.name = member_data['name']
                        if 'kinship' in member_data:
                            existing_member.kinship = member_data['kinship']
                        if 'can_receive' in member_data and member_data['can_receive'] is not None:
                            existing_member.can_receive = member_data['can_receive']
                    else:
                        member = FamilyMember(
                            name=member_data.get('name'),
                            cpf=cpf,
                            kinship=member_data.get('kinship'),
                            family_id=family.id,
                            can_receive=member_data.get('can_receive', False),
                        )
                        family.members.append(member)
            else:
                setattr(family, field, value)

        session.add(family)
        await session.commit()
        
        query = select(Family).options(selectinload(Family.members)).where(Family.id == family.id)
        result = await session.execute(query)
        family = result.scalar_one()
    except IntegrityError as e:
        print(e)
        await session.rollback()
        error_msg = str(e.orig).lower()
        if "cpf" in error_msg and ("family_members" in error_msg or "account_families" in error_msg):
             raise DuplicatedError(detail="One of the authorized persons (or the family head) has a CPF that is already registered.")
        raise

    return FamilyResp.model_validate(family)


@router.delete("/{institution_id}/families/{cpf}", status_code=204)
async def delete_family_from_institution(
    institution_id: int, cpf: str, session: Session, current_account: Annotated[Account, Depends(get_current_account)]
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
    ).options(selectinload(FamilyDelivery.family), selectinload(FamilyDelivery.attempts))

    query = (
        query.order_by(FamilyDelivery.delivery_date.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    deliveries = result.scalars().all()

    for d in deliveries:
        if d.status is None:
            d.status = SituationDelivery.PENDING
    
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
        status=SituationDelivery.PENDING,
    )
    session.add(fd)
    await session.commit()
    await session.refresh(fd)

    try:
        attempt = DeliveryAttempt(
            family_delivery_id=fd.id,
            status=DeliveryAttemptStatus.NOT_DELIVERED,
            attempt_date=payload.date.isoformat(),
            description=payload.description,
        )
        session.add(attempt)
        await session.commit()
        await session.refresh(attempt)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error while logging initial delivery attempt")
    except Exception:
        await session.rollback()
        raise

    try:
        fd.delivery_date = attempt.attempt_date
        session.add(fd)
        await session.commit()
        await session.refresh(fd)
    except Exception:
        await session.rollback()
        raise

    query = select(FamilyDelivery).options(selectinload(FamilyDelivery.family), selectinload(FamilyDelivery.attempts)).where(FamilyDelivery.id == fd.id)
    result = await session.execute(query)
    fd = result.scalar_one()

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
        select(FamilyDelivery)
        .options(selectinload(FamilyDelivery.family).selectinload(Family.deliveries))
        .where(
            FamilyDelivery.id == delivery_id,
            FamilyDelivery.institution_id == institution_id,
        )
    )
    delivery = result.scalar_one_or_none()
    if delivery is None:
        raise NotFoundError(
            detail=f"Delivery with id {delivery_id} not found in this institution"
        )
        
    
    if payload.status == SituationDelivery.COMPLETED and delivery.status != SituationDelivery.COMPLETED:
        delivery.status = SituationDelivery.COMPLETED
        delivery.delivered_at = payload.date.isoformat()
        try:
            q = (
                select(DeliveryAttempt)
                .where(DeliveryAttempt.family_delivery_id == delivery.id)
                .order_by(DeliveryAttempt.created.desc())
                .limit(1)
            )
            res = await session.execute(q)
            last_attempt = res.scalar_one_or_none()

            if last_attempt:
                last_attempt.status = DeliveryAttemptStatus.DELIVERED
                session.add(last_attempt)
                await session.commit()
                await session.refresh(last_attempt)
            else:
                raise NotFoundError(
                    detail=f"No delivery attempts found for delivery id {delivery.id}"
                )
                
            if delivery.family.is_active_for_basket:
                from datetime import datetime, timedelta
                new_delivery_date = (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%dT%H:%M:%S')
                new_delivery = FamilyDelivery(
                    institution_id=delivery.institution_id,
                    family_id=delivery.family_id,
                    delivery_date=new_delivery_date,
                    account_id=delivery.account_id,
                    description=delivery.description,
                    status=SituationDelivery.PENDING, 
                )
                session.add(new_delivery)
                await session.commit()
                await session.refresh(new_delivery)
                
        except NotFoundError:
            raise
        except IntegrityError:
            await session.rollback()
            raise DuplicatedError(detail="Error while logging delivery attempt")
        except Exception:
            await session.rollback()
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail="Error while logging delivery attempt",
            )
    else:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail="Only deliveries with status 'PENDING' can be updated",
        )
    
    await session.commit()
    await session.refresh(delivery)

    query = select(FamilyDelivery).options(selectinload(FamilyDelivery.family), selectinload(FamilyDelivery.attempts)).where(FamilyDelivery.id == delivery.id)
    result = await session.execute(query)
    delivery = result.scalar_one()

    return DeliveryResp.model_validate(delivery)

@router.post("/{institution_id}/deliveries/{delivery_id}/reschedule", status_code=201, response_model=DeliveryResp)
async def reschedule_family_delivery(    
    institution_id: int,
    current_account: Annotated[Account, Depends(get_current_account)],
    delivery_id: int,
    payload: DeliveryReschedule,
    session: Session ):
    
    await get_institution_or_404(session, institution_id)
    account = await get_account_or_404(session, payload.account_id)

    query = select(FamilyDelivery).where(
        FamilyDelivery.id == delivery_id,
        FamilyDelivery.institution_id == institution_id,
    )
    result = await session.execute(query)
    delivery = result.scalar_one_or_none()

    if delivery is None:
        raise NotFoundError(
            detail=f"Delivery with id {delivery_id} not found in this institution"
        )
    delivery.delivery_date = payload.new_date.isoformat()
    delivery.account_id = account.id

    await session.commit()
    await session.refresh(delivery)

    try:
        attempt = DeliveryAttempt(
            family_delivery_id=delivery.id,
            status=DeliveryAttemptStatus.NOT_DELIVERED,
            attempt_date=payload.new_date.isoformat(),
            description=payload.description,
        )
        session.add(attempt)
        await session.commit()
        await session.refresh(attempt)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error while logging delivery attempt")
    except Exception:
        await session.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Error while logging delivery attempt",
        )

    try:
        delivery.delivery_date = attempt.attempt_date
        session.add(delivery)
        await session.commit()
        await session.refresh(delivery)
    except Exception:
        await session.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Error while updating delivery date after logging attempt",
        )

    query = select(FamilyDelivery).options(selectinload(FamilyDelivery.family), selectinload(FamilyDelivery.attempts)).where(FamilyDelivery.id == delivery.id)
    result = await session.execute(query)
    delivery = result.scalar_one()

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

@router.get("/{institution_id}/corporate", status_code=200, response_model=List[UserCorporateResp])
async def get_users(
    institution_id: int,
    session: Session,
    current_account: Annotated[Account, Depends(get_current_account)],
):
    institution = await get_institution_or_404(session, institution_id)
    query = select(Account).options(selectinload(Account.profile)).where(Account.institution_id == institution.id).order_by(Account.account_type.asc())
    result = await session.execute(query)
    users = result.scalars().all()
    return [UserCorporateResp(user=user) for user in users]


@router.post("/{institution_id}/visit/{family_id}", status_code=201, response_model=VisitationResp)
async def create_institution_visit(
    institution_id: int,
    family_id: int,
    session: Session,
    payload: VisitationCreate,
):
    institution = await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, family_id, institution_id)

    visit = InstitutionVisitation(
        institution_id=institution.id,
        account_id=payload.account_id,
        visit_at=payload.visit_at,
        description=payload.description,
        type_of_visit=InstitutionVisitationType(payload.type_of_visit),
    )
    
    session.add(visit)
    await session.commit()
    await session.refresh(visit)

    return VisitationResp.model_validate(visit)

@router.get("/{institution_id}/visits", status_code=200, response_model=List[VisitationResp])
async def list_institution_visits(
    institution_id: int,
    session: Session,
):
    institution = await get_institution_or_404(session, institution_id)

    query = select(InstitutionVisitation).where(
        InstitutionVisitation.institution_id == institution.id
    ).order_by(InstitutionVisitation.visit_at.desc())

    result = await session.execute(query)
    visits = result.scalars().all()

    visit_ids = [v.id for v in visits]
    if visit_ids:
        responses_query = select(InstitutionVisitationResult).where(
            InstitutionVisitationResult.visitation_id.in_(visit_ids)
        )
        responses_result = await session.execute(responses_query)
        responses = responses_result.scalars().all()
        responses_dict = {r.visitation_id: r for r in responses}
    else:
        responses_dict = {}

    visits_data = []
    for v in visits:
        response_data = None
        if v.id in responses_dict:
            r = responses_dict[v.id]
            response_data = VisitationResponseReturn(
                visitation_id=r.visitation_id,
                description=r.description,
                status=r.status.value
            )
        visit_resp = VisitationResp(
            id=v.id,
            active=v.active,
            created=v.created,
            institution_id=v.institution_id,
            account_id=v.account_id,
            visit_at=v.visit_at,
            description=v.description,
            type_of_visit=v.type_of_visit.value,
            response=response_data
        )
        visits_data.append(visit_resp)

    return visits_data


@router.post("/{institution_id}/visit/{family_id}/response", status_code=200, response_model=VisitationResponseReturn)
async def create_visit_response(
    institution_id: int,
    family_id: int,
    session: Session,
    payload: VisitationCreateReturn,
):
    
    institution = await get_institution_or_404(session, institution_id)
    family = await get_family_or_404(session, family_id, institution_id)

    query = select(InstitutionVisitation).where(
        InstitutionVisitation.id == payload.visitation_id,
        InstitutionVisitation.institution_id == institution_id
    )
    result = await session.execute(query)
    visitation = result.scalar_one_or_none()

    if visitation is None:
        raise NotFoundError(detail=f"Visitation with id {payload.visitation_id} not found in this institution")

    try:
        result_obj = InstitutionVisitationResult(
            visitation_id=payload.visitation_id,
            description=payload.description,
            status=InstitutionVisitationResultType(payload.status.upper())
        )

        session.add(result_obj)
        await session.commit()
        await session.refresh(result_obj)

        return VisitationResponseReturn(
            visitation_id=result_obj.visitation_id,
            description=result_obj.description,
            status=result_obj.status.value
        )
    except IntegrityError as e:
        await session.rollback()
        raise DuplicatedError(detail="A response for this visitation already exists")
    except Exception as e:
        await session.rollback()
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")

