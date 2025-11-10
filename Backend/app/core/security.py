from typing import Optional, Annotated
from fastapi import Request, HTTPException, status, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import jwt
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.settings import Settings
from app.models.users import Account
from app.core.database import get_session

settings = Settings()


class AuthBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super().__init__(auto_error=auto_error)

    async def __call__(self, request: Request) -> Optional[int]:
        credentials: HTTPAuthorizationCredentials = await super().__call__(request)

        if not credentials:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Invalid authorization credentials",
            )

        if credentials.scheme != "Bearer":
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Invalid authentication scheme",
            )

        account_id = await self.verify_token(credentials.credentials)

        if not account_id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN, detail="Invalid or expired token"
            )

        return account_id

    async def verify_token(self, token: str) -> Optional[int]:
        try:
            payload = jwt.decode(
                token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
            )
            account_id: int = payload.get("id")

            if account_id is None:
                return None

            async for session in get_session():
                result = await session.execute(
                    select(Account).where(
                        Account.id == account_id, Account.active == True
                    )
                )
                account = result.scalar_one_or_none()

                if account:
                    return account.id

                return None

        except jwt.ExpiredSignatureError:
            return None
        except jwt.InvalidTokenError:
            return None
        except Exception:
            return None


async def get_current_account(
    session: Annotated[AsyncSession, Depends(get_session)],
    account_id: Annotated[int, Depends(AuthBearer())],
) -> Account:
    result = await session.execute(
        select(Account).where(Account.id == account_id, Account.active == True)
    )
    account = result.scalar_one_or_none()

    if not account:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Account not found or inactive",
        )

    return account
