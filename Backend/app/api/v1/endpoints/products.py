from http import HTTPStatus
from typing import Annotated, List

from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import DuplicatedError, NotFoundError
from app.models.products import StockItem
from app.schemas.products import ProductReq, ProductResp

router = APIRouter(prefix="/products", tags=["products"])
Session = Annotated[AsyncSession, Depends(get_session)]

@router.post("/", response_model=ProductResp)
async def create_product(product: ProductReq, session: Session):
    stock_item = StockItem(
        institution_id=product.institution_id,
        name=product.name,
        quantity=product.quantity
    )
    session.add(stock_item)
    try:
        await session.commit()
        await session.refresh(stock_item)
        return ProductResp.model_validate(stock_item)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Error creating product")
    
@router.get("/", response_model=List[ProductResp])
async def get_products(session: Session):
    query = select(StockItem)
    result = await session.execute(query)
    products = result.scalars().all()
    return [ProductResp.model_validate(p) for p in products]

@router.get("/{id}", response_model=ProductResp)
async def get_product(id: int, session: Session):
    query = select(StockItem).where(StockItem.id == id)
    result = await session.execute(query)
    product = result.scalar_one_or_none()
    if product is None:
        raise NotFoundError(detail="Product not found")
    return ProductResp.model_validate(product)
