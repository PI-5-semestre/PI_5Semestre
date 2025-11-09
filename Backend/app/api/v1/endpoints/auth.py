from http import HTTPStatus
from typing import TYPE_CHECKING, Annotated, List, Any, Optional

from pathlib import Path
from fastapi import APIRouter, Depends, UploadFile, File, Form
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.database import get_session
from app.core.exceptions import DuplicatedError, NotFoundError
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import selectinload

from app.core.security import AuthBearer
from app.schemas.auth import AuthResp, AuthReq

if TYPE_CHECKING:
    from models.users import Account

router = APIRouter(prefix="/auth", tags=["auth"])
Session = Annotated[AsyncSession, Depends(get_session)]

# TODO ajustar


@router.post("/login", response_model=AuthResp)
async def login(
    session: Session,
    payload: AuthReq,
):

    try:
        result = await session.execute(
            select(Account).where(
                Account.login == payload.login, Account.senha == payload.password
            )
        )
        auth = result.scalar_one_or_none()
        return AuthResp.model_validate(auth)
    except:
        return HTTPStatus.NOT_FOUND, {"message": "Conta não encontrado"}


# exemplo auxiliar ao auth

# async def get_current_user(
#     session: Session,
#     user_id: int = Depends(AuthBearer().authenticate)
# ):
