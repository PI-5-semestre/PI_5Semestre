from http import HTTPStatus
from typing import Annotated
from datetime import datetime, timedelta

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload
import jwt

from app.core.database import get_session
from app.core.exceptions import NotFoundError
from app.core.settings import Settings
from app.core.security import get_current_account
from app.schemas.auth import AuthResp, AuthReq
from app.schemas.users import UserResp
from app.models.users import Account

router = APIRouter(prefix="/auth", tags=["auth"])
Session = Annotated[AsyncSession, Depends(get_session)]
settings = Settings()


def create_access_token(account_id: int, expires_delta: timedelta = None) -> str:
    if expires_delta is None:
        expires_delta = timedelta(hours=24)

    expire = datetime.utcnow() + expires_delta
    to_encode = {"id": account_id, "exp": expire, "iat": datetime.utcnow()}

    encoded_jwt = jwt.encode(
        to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM
    )
    return encoded_jwt


@router.post("/login", response_model=AuthResp)
async def login(
    session: Session,
    payload: AuthReq,
):
    result = await session.execute(
        select(Account)
        .options(selectinload(Account.profile))
        .where(
            func.lower(Account.email) == func.lower(payload.email.lower().strip()),
            Account.password == payload.password,
            Account.active == True,
        )
    )
    account = result.scalar_one_or_none()

    if not account:
        raise HTTPException(
            status_code=HTTPStatus.UNAUTHORIZED,
            detail="Invalid credentials or inactive account",
        )

    token = create_access_token(account.id)

    return AuthResp(account=UserResp.model_validate(account), token=token)
