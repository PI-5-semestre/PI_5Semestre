from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
    Index,
    Enum,
    DECIMAL,
    Table,
    CheckConstraint,
    select,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship, Session
from sqlalchemy.sql import func
from sqlalchemy.dialects.postgresql import JSONB
from datetime import datetime
from enum import Enum as PyEnum
from typing import Optional, List, TYPE_CHECKING
from decimal import Decimal
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .families import Family
    from .Institutions import Institution

class AccountType(PyEnum):
    DELIVERY_MAN = "DELIVERY_MAN"
    ADMINISTRATIVE = "ADMINISTRATIVE"
    BENEFITED = "BENEFITED"
    INDEFINED = "INDEFINED"


class Account(BaseModel):
    __tablename__ = "accounts"

    login: Mapped[str] = mapped_column(String(50), nullable=False, unique=True)
    email: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    senha: Mapped[str] = mapped_column(String(255), nullable=False)
    account_type: Mapped[AccountType] = mapped_column(
        Enum(AccountType), nullable=False, default=AccountType.BENEFITED
    )
    family_id: Mapped[int] = mapped_column(ForeignKey("families.id"), nullable=True)

    family: Mapped["Family"] = relationship(
        "Family", back_populates="members", foreign_keys=[family_id], primaryjoin="Account.family_id == Family.id", uselist=False
    )
    owned_family: Mapped["Family"] = relationship(
        "Family", back_populates="owner", primaryjoin="Account.id == Family.owner_id", uselist=False
    )
    profile: Mapped["Profile"] = relationship(
        "Profile", back_populates="account", uselist=False
    )
    institution: Mapped["Institution"] = relationship(
        "Institution", back_populates="owner", uselist=False
    )

    __table_args__ = (Index("accounts_login_idx", login),)

    def __str__(self):
        return f"<Account(id={self.id}, login='{self.login}')>"


class Profile(BaseModel):
    __tablename__ = "profiles"

    name: Mapped[str] = mapped_column(String(200), nullable=False)
    cpf: Mapped[str] = mapped_column(String(11), nullable=False, unique=True)
    mobile: Mapped[str] = mapped_column(String(15), nullable=False)
    account_id: Mapped[int] = mapped_column(
        ForeignKey("accounts.id"), nullable=True
    )  
    account: Mapped["Account"] = relationship(
        "Account", back_populates="profile"
    ) 

    __table_args__ = (Index("profiles_cpf_idx", cpf),)
