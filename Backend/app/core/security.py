from fastapi.security import HTTPBearer as HttpBearer
import jwt
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.settings import Settings
from app.models.users import Account
from app.core.database import get_session

settings = Settings()


class AuthBearer(HttpBearer):
    def __init__(self, auto_error: bool = True):
        super().__init__(auto_error=auto_error)

    async def authenticate(self, request, token: str):
        try:
            data = jwt.decode(token, settings.SECRET_KEY, algorithms=settings.ALGORITHM)
        except jwt.exceptions.DecodeError:
            return None
        async for session in get_session():
            try:
                account = await session.get(Account, data["id"])
                if account and account.active:
                    return account.id
            except Exception:
                return None
        return None
