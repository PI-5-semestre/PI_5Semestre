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
from typing import TYPE_CHECKING, Optional, List
from decimal import Decimal
from .base_modal import BaseModel
if TYPE_CHECKING:
    from models.users import Account
    from models.Institutions import Institution
    
class SituationType(PyEnum):
    PENDING = "PENDING"
    ACTIVE = "ACTIVE"
    INACTIVE = "INACTIVE"
    SUSPENDED = "SUSPENDED"


class Family(BaseModel):
    __tablename__ = "families"

    owner_id: Mapped[int] = mapped_column(
        ForeignKey("accounts.id"), nullable=False, unique=True
    )
    family_size: Mapped[int] = mapped_column(nullable=False)

    address: Mapped[str] = mapped_column(String(300), nullable=False)
    number: Mapped[str] = mapped_column(String(10), nullable=False)
    complement: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    zipcode: Mapped[str] = mapped_column(String(9), nullable=False)
    district: Mapped[str] = mapped_column(String(100), nullable=False)
    city: Mapped[str] = mapped_column(String(100), nullable=False)
    state: Mapped[str] = mapped_column(String(2), nullable=False)

    proof_address: Mapped[Optional[dict]] = mapped_column(JSONB, nullable=True)
    proof_address_verificed: Mapped[bool] = mapped_column(Boolean, default=False)

    monthly_income: Mapped[Decimal] = mapped_column(DECIMAL(10, 2), nullable=False)
    description: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    situation_type: Mapped[SituationType] = mapped_column(
        Enum(SituationType), nullable=False, default=SituationType.PENDING
    )
    membership_id: Mapped[int] = mapped_column(
        ForeignKey("institutions.id"), nullable=False
    )
    membership: Mapped["Institution"] = relationship(
        "Institution", back_populates="families"
    )
    owner: Mapped["Account"] = relationship(
        "Account", back_populates="owned_family", foreign_keys=[owner_id], primaryjoin="Family.owner_id == Account.id"
    )
    members: Mapped[List["Account"]] = relationship(
        "Account", back_populates="family", primaryjoin="Family.id == Account.family_id"
    )
