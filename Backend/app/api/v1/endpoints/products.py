from http import HTTPStatus
from typing import Annotated, List

from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import DuplicatedError, NotFoundError
from app.models.products import StockHistory, StockItem
from app.schemas.products import ProductReq, ProductResp, ProductCreateReq, BasketReq
from app.models.Institutions import Institution
from app.models.families import Family

router = APIRouter(prefix="/products", tags=["products"])
Session = Annotated[AsyncSession, Depends(get_session)]

@router.post("/", response_model=ProductResp)
async def create_product(payload: ProductCreateReq, session: Session):
    stock_item = StockItem(
        institution_id=payload.institution_id,
        name=payload.name,
        sku=payload.sku,
        quantity=payload.quantity
    )
    session.add(stock_item)
    try:
        await session.commit()
        await session.refresh(stock_item)
        return ProductResp.model_validate(stock_item)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="Já Existe um Produto com esse SKU")
    
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


#TODO Debitar da instituição, e creditar para a familia
@router.post("/basket", response_model=List[ProductResp])
async def create_basket_for_family(session: Session, payload: BasketReq):
    
    try:
        query = select(Institution).where(Institution.id == payload.institution_id)
        result = await session.execute(query)
    except IntegrityError:
        await session.rollback()
        raise NotFoundError(detail="Institution not found")
    
    institution = result.scalar_one_or_none()
    
    try:
        query = select(Family).where(Family.id == payload.family_id)
        result = await session.execute(query)
    except IntegrityError:
        await session.rollback()
        raise NotFoundError(detail="Family not found")

    family = result.scalar_one_or_none()
    if not family:
        raise NotFoundError(detail="Family not found")
    
    if family.membership_id != institution.id:
        raise NotFoundError(detail="Family not membership from Institution")


    stock_items = []
    for product in payload.products:
        try:
            query = select(StockItem).where(StockItem.sku == product.sku, StockItem.institution_id == payload.institution_id)
            result = await session.execute(query)
            stock_item = result.scalar_one_or_none()
            if not stock_item:
                raise NotFoundError(detail="Product not found")
            stock_items.append(stock_item)
        except IntegrityError:
            await session.rollback()
            raise NotFoundError(detail="Product not found")

    return [ProductResp.model_validate(stock_item) for stock_item in stock_items]

