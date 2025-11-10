from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Query
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_session
from app.core.settings import Settings
from app.api.v1.dependencies import PaginationParams
from app.models.families import Family, SituationType
from app.schemas.families import FamilyResp

router = APIRouter(prefix="/families", tags=["families"])
Session = Annotated[AsyncSession, Depends(get_session)]

settings = Settings()


@router.get("/", response_model=list[FamilyResp])
async def list_all_families(
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: Optional[bool] = Query(None),
    institution_id: Optional[int] = Query(None, gt=0),
    situation: Optional[str] = Query(None),
):
    query = select(Family)

    if active is not None:
        query = query.where(Family.active == active)

    if institution_id is not None:
        query = query.where(Family.institution_id == institution_id)

    if situation is not None:
        try:
            sit_type = SituationType[situation.upper()]
            query = query.where(Family.situation == sit_type)
        except (ValueError, KeyError):
            from app.core.exceptions import NotFoundError

            raise NotFoundError(detail=f"Invalid situation type: {situation}")

    query = (
        query.order_by(Family.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    families = result.scalars().all()

    return [FamilyResp.model_validate(fam) for fam in families]
