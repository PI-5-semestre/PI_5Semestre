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
from dateutil.relativedelta import relativedelta

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

    benefit_expiration_date: Mapped[Optional[datetime]] = mapped_column(
        nullable=True
    )

    membership: Mapped["Institution"] = relationship(
        "Institution", back_populates="families"
    )
    owner: Mapped["Account"] = relationship(
        "Account",
        back_populates="owned_family",
        foreign_keys=[owner_id],
        primaryjoin="Family.owner_id == Account.id",
    )
    members: Mapped[List["Account"]] = relationship(
        "Account", back_populates="family", primaryjoin="Family.id == Account.family_id"
    )
    
    visits: Mapped[List["VisitFamily"]] = relationship(
        "VisitFamily", back_populates="family", primaryjoin="Family.id == VisitFamily.family_id"
    )
    def add_benefit(self):
            if self.benefit_expiration_date:
                self.benefit_expiration_date += relativedelta(months=3)
            else:
                self.benefit_expiration_date = datetime.now() + relativedelta(months=3)
            return self.benefit_expiration_date

    def has_necessity(self):
            if self.benefit_expiration_date:
                self.benefit_expiration_date += relativedelta(months=1)
            return self.benefit_expiration_date
        
    def remove_benefit(self):
            self.benefit_expiration_date = None
            return self.benefit_expiration_date


class VisitFamily(BaseModel):
    __tablename__ = "visitfamilies"

    family_id: Mapped[int] = mapped_column(ForeignKey("families.id"), nullable=False)
    visit_date: Mapped[datetime] = mapped_column(nullable=False)  
    attempt_count: Mapped[int] = mapped_column(default=0)
    success: Mapped[bool] = mapped_column(default=False)
    description: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)

    family: Mapped["Family"] = relationship("Family", back_populates="visits")

    def reschedule(self, new_date: datetime):
        self.attempt_count += 1
        if self.attempt_count >= 3:
            self.success = False
            self.description = "Maximum reschedule attempts reached"
            raise Exception("Maximum reschedule attempts reached")
        else:
            self.visit_date = new_date

