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
from .users import Account

if TYPE_CHECKING:
    from .Institutions import Institution


class StockItem(BaseModel):
    __tablename__ = "stock_items"

    institution_id: Mapped[int] = mapped_column(ForeignKey("institutions.id"))
    name: Mapped[str] = mapped_column(String(200), nullable=False)
    sku : Mapped[str] = mapped_column(String(200), nullable=False, unique=True)
    
    
    quantity: Mapped[int] = mapped_column(default=0)
    institution: Mapped["Institution"] = relationship(
        "Institution", back_populates="stock_items"
    )
    history: Mapped[List["StockHistory"]] = relationship(
        "StockHistory", back_populates="stock_item"
    )


class StockHistory(BaseModel):
    __tablename__ = "stock_history"

    stock_item_id: Mapped[int] = mapped_column(ForeignKey("stock_items.id"))
    quantity: Mapped[int] = mapped_column(nullable=False)
    stock_item: Mapped["StockItem"] = relationship(
        "StockItem", back_populates="history"
    )
    