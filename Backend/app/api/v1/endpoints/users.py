from http import HTTPStatus
from typing import Annotated

from fastapi import APIRouter, Depends, Query
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import DuplicatedError, NotFoundError
from app.models.users import Account
from app.schemas.users import UserReq, UserResp

router = APIRouter(prefix='/users', tags=['users'])
Session = Annotated[AsyncSession, Depends(get_session)]

@router.post("/", response_model=UserResp)
async def create_users(payload: UserReq, session: Session):
    account = Account(login=payload.login, email=payload.email, senha=payload.senha, family_id=payload.family_id, institution_id=payload.institution_id)
    session.add(account)
    try:
        await session.commit()
        await session.refresh(account)
        return UserResp.model_validate(account)
    except IntegrityError:
        await session.rollback()
        raise DuplicatedError(detail="User with this login or email already exists")
    
@router.get("/", response_model=list[UserResp])
async def get_users(session: Session):
    result = await session.execute(select(Account))
    accounts = result.scalars().all()
    return [UserResp.model_validate(acc) for acc in accounts]

@router.get("/{id}", response_model=UserResp)
async def get_user(id: int, session: Session):
    result = await session.execute(select(Account).where(Account.id == id))
    account = result.scalar_one_or_none()
    if account is None:
        raise NotFoundError(detail="User not found")
    return UserResp.model_validate(account)