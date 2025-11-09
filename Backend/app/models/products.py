from sqlalchemy import String, ForeignKey, Index, CheckConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship
from typing import List, TYPE_CHECKING
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .Institutions import Institution


class StockItem(BaseModel):
    __tablename__ = "stock_items"

    institution_id: Mapped[int] = mapped_column(
        ForeignKey("institutions.id", ondelete="CASCADE"), nullable=False, index=True
    )

    name: Mapped[str] = mapped_column(String(200), nullable=False)
    sku: Mapped[str] = mapped_column(String(100), nullable=False)
    quantity: Mapped[int] = mapped_column(default=0, nullable=False)

    institution: Mapped["Institution"] = relationship(
        "Institution", back_populates="stock_items"
    )

    history: Mapped[List["StockHistory"]] = relationship(
        "StockHistory",
        back_populates="stock_item",
        cascade="all, delete-orphan",
        order_by="desc(StockHistory.created)",
    )

    __table_args__ = (
        Index("idx_stock_sku_institution", "sku", "institution_id", unique=True),
        Index("idx_stock_institution", "institution_id"),
        CheckConstraint("quantity >= 0", name="check_quantity_positive"),
    )

    def __repr__(self):
        return f"<StockItem(id={self.id}, name='{self.name}', sku='{self.sku}', qty={self.quantity})>"


class StockHistory(BaseModel):
    __tablename__ = "stock_history"

    stock_item_id: Mapped[int] = mapped_column(
        ForeignKey("stock_items.id", ondelete="CASCADE"), nullable=False, index=True
    )
    quantity: Mapped[int] = mapped_column(nullable=False)

    stock_item: Mapped["StockItem"] = relationship(
        "StockItem", back_populates="history"
    )

    __table_args__ = (
        Index("idx_stock_history_item", "stock_item_id"),
        Index("idx_stock_history_created", "created"),
    )

    def __repr__(self):
        return f"<StockHistory(id={self.id}, item_id={self.stock_item_id}, qty={self.quantity})>"
