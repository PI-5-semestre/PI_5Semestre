from http import HTTPStatus
from typing import Annotated, List, Any, Optional
import os
import uuid
from pathlib import Path
from fastapi import APIRouter, Depends, UploadFile, File, Form
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import DuplicatedError, NotFoundError
from app.models.families import Family, VisitFamily
from app.models.users import Account
from app.schemas.families import (
    BeneficitReq,
    FamilyReq,
    FamilyResp,
    ParticipantesResp,
    VisitReq,
    VisitResp,
)
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import selectinload

router = APIRouter(prefix="/families", tags=["families"])
Session = Annotated[AsyncSession, Depends(get_session)]

UPLOAD_DIR = Path("app/media/proof_address")
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

ALLOWED_EXTENSIONS = {".pdf", ".png", ".jpg", ".jpeg"}
MAX_FILE_SIZE = 5 * 1024 * 1024


@router.get("/", response_model=List[FamilyResp])
async def get_families(session: Session):
    result = await session.execute(select(Family).options(selectinload(Family.visits)))
    families = result.scalars().all()
    return [FamilyResp.model_validate(fam) for fam in families]


@router.get("/{id}", response_model=FamilyResp)
async def get_family(id: int, session: Session):
    result = await session.execute(select(Family).options(selectinload(Family.visits)))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")

    res = await session.execute(select(Account).where(Account.family_id == id))
    accounts = res.scalars().all()
    users = (
        [
            ParticipantesResp(
                login=acc.login,
                family_id=acc.family_id,
                institution_id=acc.institution_id,
                account_type=acc.account_type,
            )
            for acc in accounts
        ]
        if accounts
        else None
    )

    family_resp = FamilyResp.model_validate(family)
    family_resp.accounts = users
    return family_resp


@router.post("/", response_model=FamilyResp)
async def create_families(payload: FamilyReq, session: Session):
    f = Family(
        owner_id=payload.owner_id,
        family_size=payload.family_size,
        address=payload.address,
        number=payload.number,
        complement=payload.complement,
        zipcode=payload.zipcode,
        district=payload.district,
        city=payload.city,
        state=payload.state,
        monthly_income=payload.monthly_income,
        description=payload.description,
        situation_type=payload.situation_type,
        membership_id=payload.membership_id,
    )
    session.add(f)
    try:
        await session.commit()
        await session.refresh(f)
        return FamilyResp.model_validate(f)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error creating Family")


async def save_proof_address(file: UploadFile) -> dict:

    file_ext = Path(file.filename).suffix.lower()
    if file_ext not in ALLOWED_EXTENSIONS:
        raise ValueError(
            f"Tipo de arquivo não permitido. Use: {', '.join(ALLOWED_EXTENSIONS)}"
        )

    unique_filename = f"{uuid.uuid4()}{file_ext}"
    file_path = UPLOAD_DIR / unique_filename

    content = await file.read()

    if len(content) > MAX_FILE_SIZE:
        raise ValueError(
            f"Arquivo muito grande. Tamanho máximo: {MAX_FILE_SIZE / (1024 * 1024)}MB"
        )

    with open(file_path, "wb") as f:
        f.write(content)

    return {
        "filename": file.filename,
        "saved_as": unique_filename,
        "path": str(file_path),
        "size": len(content),
        "content_type": file.content_type,
    }


@router.post("/{id}/upload-proof", response_model=Any)
async def upload_proof_address(
    id: int,
    session: Session,
    proof_address_file: UploadFile = File(...),
):

    result = await session.execute(select(Family).where(Family.id == id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")

    try:
        proof_address_data = await save_proof_address(proof_address_file)
    except ValueError as e:
        raise DuplicatedError(detail=str(e))

    if family.proof_address:
        old_file_path = Path(family.proof_address.get("path", ""))
        if old_file_path.exists():
            old_file_path.unlink()

    family.proof_address = proof_address_data
    family.proof_address_verificed = True

    try:
        await session.commit()
        return {
            "message": "Proof of address uploaded successfully",
            "code": 200,
            "file_info": proof_address_data,
        }
    except IntegrityError:
        await session.rollback()
        file_path = Path(proof_address_data["path"])
        if file_path.exists():
            file_path.unlink()
        raise DuplicatedError(detail="Error updating family")


@router.post("/add", response_model=FamilyResp)
async def add_beneficit(payload: BeneficitReq, session: Session):
    result = await session.execute(select(Family).where(Family.id == payload.id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")
    family.add_benefit()
    try:
        await session.commit()
        await session.refresh(family)
        return FamilyResp.model_validate(family)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error adding benefit")


@router.post("/remove", response_model=FamilyResp)
async def remove_beneficit(payload: BeneficitReq, session: Session):
    result = await session.execute(select(Family).where(Family.id == payload.id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")
    family.remove_benefit()
    try:
        await session.commit()
        await session.refresh(family)
        return FamilyResp.model_validate(family)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error removing benefit")


@router.post("/visits", response_model=VisitResp)
async def create_visit(payload: VisitReq, session: Session):
    result = await session.execute(select(Family).where(Family.id == payload.family_id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")

    result1 = await session.execute(
        select(VisitFamily)
        .where(VisitFamily.family_id == payload.family_id, VisitFamily.active == True)
        .limit(1)
    )
    existing_visit = result1.scalar_one_or_none()
    if existing_visit:
        raise DuplicatedError(detail="Active visit already scheduled for this family")

    new_visit = VisitFamily(
        family_id=payload.family_id,
        visit_date=payload.visit_date,
        attempt_count=0,
        success=False,
        description=None,
    )
    session.add(new_visit)
    try:
        await session.commit()
        await session.refresh(new_visit)
        return VisitResp.model_validate(new_visit)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error creating visit")


@router.post("/visits/reschedule", response_model=VisitResp)
async def reschedule_visit(payload: VisitReq, session: Session):
    result = await session.execute(select(Family).where(Family.id == payload.family_id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")

    result = await session.execute(
        select(VisitFamily)
        .where(VisitFamily.family_id == payload.family_id)
        .order_by(VisitFamily.visit_date.desc())
    )
    current_visit = result.scalar_one_or_none()
    if current_visit is None:
        raise NotFoundError(detail="No visit found for this family")

    current_visit.reschedule(payload.visit_date)

    try:
        await session.commit()
        await session.refresh(current_visit)
        return VisitResp.model_validate(current_visit)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error rescheduling visit")


@router.get("/{family_id}/visits", response_model=List[VisitResp])
async def get_visits(family_id: int, session: Session):
    result = await session.execute(select(Family).where(Family.id == family_id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")

    result = await session.execute(
        select(VisitFamily).where(VisitFamily.family_id == family_id)
    )
    visits = result.scalars().all()
    return [VisitResp.model_validate(visit) for visit in visits]
