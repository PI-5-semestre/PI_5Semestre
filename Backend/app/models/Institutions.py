from sqlalchemy import ForeignKey, String, Index, Enum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from enum import Enum as PyEnum
from typing import List, TYPE_CHECKING, Any

from app.models.products import StockItem
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .users import Account
    from .families import Family, FamilyDelivery


class InstitutionType(PyEnum):
    ONGS = "ONGS"
    CHURCH = "CHURCH"

class BasketType(PyEnum):
    P = "P"
    M = "M"
    G = "G"

class InstitutionVisitationType(PyEnum):
    ADMISSION="ADMISSION"
    READMISSION="READMISSION"
    ROUTINE="ROUTINE"
    
class InstitutionVisitationResultType(PyEnum):
    ACCEPTED="ACCEPTED"
    REJECTED="REJECTED"
    PENDING="PENDING"

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

class BasketsInstitutions(BaseModel):
    __tablename__ = "baskets_institutions"

    institution_id: Mapped[int] = mapped_column(
        nullable=False
    )
    
    family_id: Mapped[int] = mapped_column(
        ForeignKey("account_families.id", ondelete="CASCADE"), nullable=False, index=True
    )
    
    basket_type: Mapped[BasketType] = mapped_column(
        Enum(BasketType, native_enum=False), nullable=False
    )

    family: Mapped["Family"] = relationship(
        "Family", foreign_keys=[family_id]
    )

    products: Mapped[List["ProductsBasketsInstitutions"]] = relationship(
        "ProductsBasketsInstitutions", back_populates="basket", cascade="all, delete-orphan"
    )

    def __repr__(self):
        return f"<BasketsInstitutions(id={self.id}, institution_id={self.institution_id}, basket_type='{self.basket_type.value}')>"
    
    
class ProductsBasketsInstitutions(BaseModel):
    __tablename__ = "products_baskets_institutions"

    basket_id: Mapped[int] = mapped_column(
        ForeignKey("baskets_institutions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    product_sku: Mapped[str] = mapped_column(
        String(100), nullable=False
    )
    quantity: Mapped[int] = mapped_column(
        default=1, nullable=False
    )

    basket: Mapped["BasketsInstitutions"] = relationship(
        "BasketsInstitutions", back_populates="products"
    )

    product: Mapped["StockItem"] = relationship(
        "StockItem", 
        primaryjoin="and_(ProductsBasketsInstitutions.product_sku == StockItem.sku, foreign(ProductsBasketsInstitutions.basket_id) == BasketsInstitutions.id, foreign(BasketsInstitutions.institution_id) == StockItem.institution_id)",
        viewonly=True
    )

    def __repr__(self):
        return f"<ProductsBasketsInstitutions(id={self.id}, basket_id={self.basket_id}, product_sku='{self.product_sku}', quantity={self.quantity})>"
    
    
class InstitutionVisitation(BaseModel):
    __tablename__ = "institution_visitations"

    institution_id: Mapped[int] = mapped_column(
        ForeignKey("institutions.id", ondelete="CASCADE"), nullable=False, index=True
    )
    account_id: Mapped[int] = mapped_column(
        ForeignKey("accounts.id", ondelete="CASCADE"), nullable=False, index=True
    )
    visit_at: Mapped[str] = mapped_column(
        String(25), nullable=False
    )
    description: Mapped[str] = mapped_column(
        String(500), nullable=True
    )

    type_of_visit: Mapped[InstitutionVisitationType] = mapped_column(
        Enum(InstitutionVisitationType, native_enum=False), nullable=False
    )
    
    def __repr__(self):
        return f"<InstitutionView(id={self.id}, name='{self.name}', type='{self.institution_type.value}')>"
    
class InstitutionVisitationResult(BaseModel):
    __tablename__ = "institution_visitation_results"

    visitation_id: Mapped[int] = mapped_column(
        ForeignKey("institution_visitations.id", ondelete="CASCADE"), nullable=False, index=True
    )
    description: Mapped[str] = mapped_column(
        String(500), nullable=False
    )
    
    status: Mapped[InstitutionVisitationResultType] = mapped_column(
        Enum(InstitutionVisitationResultType, native_enum=False, default=InstitutionVisitationResultType.PENDING), nullable=False
    )
    
    def __repr__(self):
        return f"<InstitutionVisitationResult(id={self.id}, visitation_id={self.visitation_id})>"