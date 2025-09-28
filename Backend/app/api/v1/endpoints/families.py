from http import HTTPStatus
from typing import Annotated, List

from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import NotFoundError
from app.models.families import Family
from app.schemas.families import FamilyResp

router = APIRouter(prefix="/families", tags=["families"])
Session = Annotated[AsyncSession, Depends(get_session)]


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


# TODO fazer o create
