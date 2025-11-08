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

from app.models import Account, AccountType, Institution, InstitutionType
from app.core.database import engine

async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)


async def _create_owner_and_institution(
    email: str, password: str, name: str, institution_type: str
):
    async with async_session() as session:
        inst_type = InstitutionType(institution_type.upper())
        institution = Institution(name=name, institution_type=inst_type)
        session.add(institution)
        await session.commit()
        await session.refresh(institution)

        account = Account(
            email=email,
            password=password,
            account_type=AccountType.OWNER,
            institution_id=institution.id,
        )
        session.add(account)
        await session.commit()
        await session.refresh(account)

        typer.echo(f"{institution.name} (ID: {institution.id})")
        typer.echo(f"{account.email} (ID: {account.id})")


def create_owner_and_institution(
    email: str = typer.Argument(..., help="Email do proprietário"),
    password: str = typer.Argument(..., help="Senha do proprietário"),
    name: str = typer.Argument(..., help="Nome da instituição"),
    institution_type: str = typer.Argument(
        ..., help="Tipo da instituição (ONGS ou CHURCH)"
    ),
):
    asyncio.run(_create_owner_and_institution(email, password, name, institution_type))


if __name__ == "__main__":
    typer.run(create_owner_and_institution)
