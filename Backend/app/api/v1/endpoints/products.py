from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Query
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.database import get_session
from app.core.settings import Settings
from app.api.v1.dependencies import PaginationParams
from app.models.products import StockItem, StockHistory
from app.schemas.products import StockItemResp, StockHistoryResp

router = APIRouter(prefix="/products", tags=["products"])
Session = Annotated[AsyncSession, Depends(get_session)]

settings = Settings()


@router.get("/", response_model=list[StockItemResp])
async def list_all_products(
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: Optional[bool] = Query(None),
    institution_id: Optional[int] = Query(None, gt=0),
):
    query = select(StockItem)

    if active is not None:
        query = query.where(StockItem.active == active)

    if institution_id is not None:
        query = query.where(StockItem.institution_id == institution_id)

    query = (
        query.order_by(StockItem.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    products = result.scalars().all()

    return [StockItemResp.model_validate(p) for p in products]


@router.get("/history", response_model=list[StockHistoryResp])
async def list_all_stock_history(
    session: Session,
    pagination: dict = Depends(PaginationParams),
):
    query = (
        select(StockHistory)
        .order_by(StockHistory.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    history = result.scalars().all()

    return [StockHistoryResp.model_validate(h) for h in history]
