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
from app.models.families import Family
from app.schemas.families import FamilyReq, FamilyResp
from sqlalchemy.exc import IntegrityError

router = APIRouter(prefix="/families", tags=["families"])
Session = Annotated[AsyncSession, Depends(get_session)]

UPLOAD_DIR = Path("app/media/proof_address")
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

ALLOWED_EXTENSIONS = {".pdf", ".png", ".jpg", ".jpeg"}
MAX_FILE_SIZE = 5 * 1024 * 1024


@router.get("/", response_model=List[FamilyResp])
async def get_families(session: Session):
    result = await session.execute(select(Family))
    families = result.scalars().all()
    return [FamilyResp.model_validate(fam) for fam in families]


@router.get("/{id}", response_model=FamilyResp)
async def get_family(id: int, session: Session):
    result = await session.execute(select(Family).where(Family.id == id))
    family = result.scalar_one_or_none()
    if family is None:
        raise NotFoundError(detail="Family not found")
    return FamilyResp.model_validate(family)


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
    family.proof_address_verificed = False

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
