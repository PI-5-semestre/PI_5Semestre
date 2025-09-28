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

from app.models.products import StockItem
from .base_modal import BaseModel
if TYPE_CHECKING:
    from .users import Account
    from .families import Family


class InstitutionType(PyEnum):
    ONGS = "ONGS"
    CHURCH = "CHURCH"


class Institution(BaseModel):
    __tablename__ = "institutions"

    name: Mapped[str] = mapped_column(String(200), nullable=False)
    institutions_type: Mapped[InstitutionType] = mapped_column(
        Enum(InstitutionType), nullable=False
    )
    owner_id: Mapped[int] = mapped_column(
        ForeignKey("accounts.id"), nullable=False, unique=True
    )
    __table_args__ = (Index("institutions_name_idx", name),)
    owner: Mapped["Account"] = relationship("Account", back_populates="institution")
    families: Mapped[List["Family"]] = relationship(
        "Family", back_populates="membership"
    ) 
    stock_items: Mapped[List["StockItem"]] = relationship(
        "StockItem", back_populates="institution"
    )

    def __str__(self):
        return f"<Institution(id={self.id}, name='{self.name}', type='{self.institutions_type.value}')>"

    def affiliation(self):
        return f"https://www.google.com/?affiliation={self.id}"
