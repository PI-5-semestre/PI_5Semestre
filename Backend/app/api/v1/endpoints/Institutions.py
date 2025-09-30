from http import HTTPStatus
from typing import Annotated

from fastapi import APIRouter, Depends, Query
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import NotFoundError
from app.schemas.Institutions import InstitutionResp
from app.models.Institutions import Institution

router = APIRouter(prefix='/institutions', tags=['institutions'])
Session = Annotated[AsyncSession, Depends(get_session)]

@router.get("/", response_model=list[InstitutionResp])
async def get_institutions(session: Session):
    result = await session.execute(select(Institution))
    institutions = result.scalars().all()
    return [InstitutionResp.model_validate(inst) for inst in institutions]

@router.get("/{id}", response_model=InstitutionResp)
async def get_institution(id: int, session: Session):
    result = await session.execute(select(Institution).where(Institution.id == id))
    institution = result.scalar_one_or_none()
    if institution is None:
        raise NotFoundError(detail="Institution not found")
    return InstitutionResp.model_validate(institution)