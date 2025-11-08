from http import HTTPStatus
from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Query
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import joinedload

from app.core.database import get_session
from app.core.settings import Settings
from app.core.exceptions import DuplicatedError, NotFoundError
from app.api.v1.dependencies import PaginationParams
from app.models.users import Account, Profile, AccountType
from app.schemas.users import UserCreate, UserUpdate, UserResp

router = APIRouter(prefix="/users", tags=["users"])
Session = Annotated[AsyncSession, Depends(get_session)]

settings = Settings()


@router.post("/", response_model=UserResp, status_code=HTTPStatus.CREATED)
async def create_user(payload: UserCreate, session: Session):
    try:
        account_type = AccountType.VOLUNTEER
        if payload.account_type:
            try:
                account_type = AccountType(payload.account_type.upper())
            except ValueError:
                pass

        account = Account(
            email=payload.email,
            password=payload.password,
            account_type=account_type,
            institution_id=payload.institution_id,
        )
        session.add(account)
        await session.flush()

        profile = Profile(
            name=payload.name,
            cpf=payload.cpf,
            mobile=payload.mobile,
            account_id=account.id,
        )
        session.add(profile)
        await session.commit()

        result = await session.execute(
            select(Account)
            .options(joinedload(Account.profile))
            .where(Account.id == account.id)
        )
        account = result.unique().scalar_one()

        return UserResp.model_validate(account)

    except IntegrityError as e:
        await session.rollback()
        error_msg = str(e.orig).lower()

        if "email" in error_msg or "accounts_email" in error_msg:
            raise DuplicatedError(detail="Email already registered")
        elif "cpf" in error_msg or "profiles_cpf" in error_msg:
            raise DuplicatedError(detail="CPF already registered")
        elif "institution" in error_msg:
            raise NotFoundError(detail="Institution not found")

        raise DuplicatedError(detail="Duplicate entry")

    except Exception:
        await session.rollback()
        raise


@router.get("/", response_model=list[UserResp])
async def list_users(
    session: Session,
    pagination: dict = Depends(PaginationParams),
    active: Optional[bool] = Query(None),
    institution_id: Optional[int] = Query(None, gt=0),
):
    query = select(Account).options(joinedload(Account.profile))

    if active is not None:
        query = query.where(Account.active == active)

    if institution_id is not None:
        query = query.where(Account.institution_id == institution_id)

    query = (
        query.order_by(Account.created.desc())
        .offset(pagination["skip"])
        .limit(pagination["limit"])
    )

    result = await session.execute(query)
    accounts = result.unique().scalars().all()

    return [UserResp.model_validate(acc) for acc in accounts]


@router.get("/{email}", response_model=UserResp)
async def get_user(email: str, session: Session):
    result = await session.execute(
        select(Account)
        .options(joinedload(Account.profile))
        .where(Account.email == email.lower())
    )
    account = result.unique().scalar_one_or_none()

    if account is None:
        raise NotFoundError(detail=f"User with email '{email}' not found")

    return UserResp.model_validate(account)


@router.put("/{email}", response_model=UserResp)
async def update_user(email: str, payload: UserUpdate, session: Session):
    try:
        result = await session.execute(
            select(Account)
            .options(joinedload(Account.profile))
            .where(Account.email == email.lower())
        )
        account = result.unique().scalar_one_or_none()

        if account is None:
            raise NotFoundError(detail=f"User with email '{email}' not found")

        if payload.email is not None:
            account.email = payload.email.lower()

        if payload.password is not None:
            account.password = payload.password

        if payload.account_type is not None:
            try:
                account.account_type = AccountType[payload.account_type.upper()]
            except (ValueError, KeyError):
                raise NotFoundError(
                    detail=f"Invalid account type: {payload.account_type}"
                )

        if payload.institution_id is not None:
            account.institution_id = payload.institution_id

        profile_data = {
            "name": payload.name,
            "cpf": payload.cpf,
            "mobile": payload.mobile,
        }

        has_profile_data = any(v is not None for v in profile_data.values())

        if has_profile_data:
            if account.profile is None:
                profile = Profile(
                    name=payload.name or "",
                    cpf=payload.cpf or "",
                    mobile=payload.mobile or "",
                    account_id=account.id,
                )
                session.add(profile)
            else:
                if payload.name is not None:
                    account.profile.name = payload.name
                if payload.cpf is not None:
                    account.profile.cpf = payload.cpf
                if payload.mobile is not None:
                    account.profile.mobile = payload.mobile

        await session.commit()

        result = await session.execute(
            select(Account)
            .options(joinedload(Account.profile))
            .where(Account.id == account.id)
        )
        account = result.unique().scalar_one()

        return UserResp.model_validate(account)

    except IntegrityError as e:
        await session.rollback()
        error_msg = str(e.orig).lower()

        if "email" in error_msg or "accounts_email" in error_msg:
            raise DuplicatedError(detail="Email already in use")
        elif "cpf" in error_msg or "profiles_cpf" in error_msg:
            raise DuplicatedError(detail="CPF already in use")

        raise DuplicatedError(detail="Duplicate data")

    except NotFoundError:
        raise

    except Exception:
        await session.rollback()
        raise


@router.delete("/{email}", status_code=HTTPStatus.NO_CONTENT)
async def delete_user(email: str, session: Session):
    result = await session.execute(
        select(Account).where(Account.email == email.lower())
    )
    account = result.scalar_one_or_none()

    if account is None:
        raise NotFoundError(detail=f"User with email '{email}' not found")

    account.active = False

    try:
        await session.commit()
    except Exception:
        await session.rollback()
        raise

    return None
