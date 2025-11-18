from sqlalchemy import String, Index, Enum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from enum import Enum as PyEnum
from typing import List, TYPE_CHECKING, Any
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .users import Account
    from .families import Family, FamilyDelivery


class InstitutionType(PyEnum):
    ONGS = "ONGS"
    CHURCH = "CHURCH"


class Institution(BaseModel):
    __tablename__ = "institutions"

    name: Mapped[str] = mapped_column(String(200), nullable=False, index=True)
    institution_type: Mapped[InstitutionType] = mapped_column(
        Enum(InstitutionType, native_enum=False), nullable=False
    )

    accounts: Mapped[List["Account"]] = relationship(
        "Account", back_populates="institution"
    )

    families: Mapped[List["Family"]] = relationship(
        "Family", back_populates="membership", cascade="all, delete-orphan"
    )

    stock_items: Mapped[List[Any]] = relationship(
        "StockItem", back_populates="institution", cascade="all, delete-orphan"
    )
    
    deliveries: Mapped[List[Any]] = relationship(
        "FamilyDelivery", back_populates="institution", cascade="all, delete-orphan"
    )

    __table_args__ = (
        Index("idx_institutions_name", "name"),
        Index("idx_institutions_type", "institution_type"),
    )

    def __repr__(self):
        return f"<Institution(id={self.id}, name='{self.name}', type='{self.institution_type.value}')>"
