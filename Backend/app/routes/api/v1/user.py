from http import HTTPStatus
from typing import Annotated, List

from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import IntegrityError

from app.schemas.schemas import UserRequest, UserResponse
from app.models.models import Account, AccountType
from app.core.database import get_session

Session = Annotated[AsyncSession, Depends(get_session)]

router = APIRouter(prefix='/user', tags=['User'])

@router.post('/', response_model=UserResponse, status_code=HTTPStatus.CREATED)
async def create(user_data: UserRequest, db: Session):
    try:
        get_account_type = lambda type_val: {
            0: AccountType.BENEFITED,
            1: AccountType.DELIVERY_MAN,
            2: AccountType.ADMINISTRATIVE
        }.get(type_val, AccountType.INDEFINED)

        new_user = Account(
            login=user_data.login,
            senha=user_data.senha,
            account_type=get_account_type(user_data.account_type),
        )
        
        db.add(new_user)
        await db.commit()
        await db.refresh(new_user)
        
        return new_user
    
    except IntegrityError:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.CONFLICT,
            detail="User with this login already exists"
        )
    except Exception as e:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Error creating user: {str(e)}"
        )
    
@router.put('/{login}', response_model=UserResponse, status_code=HTTPStatus.OK)
async def update(login: str, user_data: UserRequest, db: Session):
    try:
        get_account_type = lambda type_val: {
            0: AccountType.BENEFITED,
            1: AccountType.DELIVERY_MAN,
            2: AccountType.ADMINISTRATIVE
        }.get(type_val, AccountType.INDEFINED)

        user = await db.scalar(select(Account).where(Account.login == login))
        
        if not user:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail="Resource not found"
            )
        
        if user_data.account_type != user.account_type.value:
            user.account_type = get_account_type(user_data.account_type)
        
        user.senha = user_data.senha
        
        await db.commit()
        await db.refresh(user)
        return user
    
    except HTTPException:
        raise
    except IntegrityError:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.CONFLICT,
            detail="Login already in use by another user"
        )
    except Exception as e:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Error updating user: {str(e)}"
        )
    
@router.get('/', response_model=List[UserResponse], status_code=HTTPStatus.OK)
async def list_all(db: Session):
    try:
        users = await db.scalars(select(Account))
        return users.all()
    
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Error retrieving users: {str(e)}"
        )

@router.get('/{user_id}', response_model=UserResponse, status_code=HTTPStatus.OK)
async def get_by_id(user_id: int, db: Session):
    try:
        user = await db.scalar(select(Account).where(Account.id == user_id))
        
        if not user:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail=f"User with ID {user_id} not found"
            )
        
        return user
    
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Error retrieving user: {str(e)}"
        )
    
