import sys
import os

sys.path.insert(
    0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)

import dotenv

dotenv.load_dotenv()

import typer
import asyncio
from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import sessionmaker

from app.models.users import Account, AccountType
from app.models.Institutions import Institution, InstitutionType
from app.models.families import Family
from app.core.database import engine

async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)


async def _create_owner_and_institution(
    login: str, email: str, senha: str, name: str, institutions_type: str
):
    async with async_session() as session:
        account = Account(
            login=login,
            email=email,
            senha=senha,
            account_type=AccountType.ADMINISTRATIVE,
            family_id=None,
        )
        session.add(account)
        await session.commit()
        await session.refresh(account)

        inst_type = InstitutionType(institutions_type.upper())
        institution = Institution(
            name=name, institutions_type=inst_type, owner_id=account.id
        )
        session.add(institution)
        await session.commit()
        await session.refresh(institution)

        typer.echo(f"Created account {account.id} and institution {institution.id}")


def create_owner_and_institution(
    login: str, email: str, senha: str, name: str, institutions_type: str
):
    asyncio.run(
        _create_owner_and_institution(login, email, senha, name, institutions_type)
    )


if __name__ == "__main__":
    typer.run(create_owner_and_institution)
