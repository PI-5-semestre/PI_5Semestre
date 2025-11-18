from sqlalchemy import (
    String,
    ForeignKey,
    Index,
    Enum,
    DECIMAL,
    CheckConstraint,
    LargeBinary,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship
from enum import Enum as PyEnum
from typing import TYPE_CHECKING, Optional, List
from decimal import Decimal
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .Institutions import Institution
    from .users import Account


class SituationType(str, PyEnum):
    PENDING = "PENDING"
    ACTIVE = "ACTIVE"
    INACTIVE = "INACTIVE"
    SUSPENDED = "SUSPENDED"


class Family(BaseModel):
    __tablename__ = "account_families"

    name: Mapped[str] = mapped_column(
        String(100), nullable=False, comment="Nome do responsável pela família"
    )
    cpf: Mapped[str] = mapped_column(
        String(11),
        nullable=False,
        unique=True,
        index=True,
        comment="CPF do responsável",
    )
    mobile_phone: Mapped[str] = mapped_column(
        String(15), nullable=False, comment="Telefone celular para contato"
    )

    zip_code: Mapped[str] = mapped_column(
        String(9), nullable=False, comment="CEP do endereço"
    )
    street: Mapped[str] = mapped_column(String(100), nullable=False, comment="Nome da rua")
    number: Mapped[str] = mapped_column(
        String(10), nullable=False, comment="Número do endereço"
    )
    neighborhood: Mapped[str] = mapped_column(
        String(100), nullable=False, comment="Nome do bairro"
    )
    state: Mapped[str] = mapped_column(
        String(2), nullable=False, comment="UF do estado"
    )

    situation: Mapped[SituationType] = mapped_column(
        Enum(SituationType, native_enum=False),
        nullable=False,
        default=SituationType.PENDING,
        index=True,
        comment="Situação atual da família no programa",
    )
    income: Mapped[Decimal] = mapped_column(
        DECIMAL(10, 2),
        nullable=False,
        default=Decimal("0.00"),
        comment="Renda mensal da família",
    )
    description: Mapped[Optional[str]] = mapped_column(
        String(500), nullable=True, comment="Observações adicionais sobre a família"
    )

    institution_id: Mapped[int] = mapped_column(
        ForeignKey("institutions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
        comment="Instituição responsável pela família",
    )
    
    size: Mapped[int] = mapped_column(
        default=1,
        nullable=False,
        comment="Número de membros na família"
    )
    
    membership: Mapped["Institution"] = relationship(
        "Institution", back_populates="families", lazy="joined"
    )
    documents: Mapped[List["DocFamily"]] = relationship(
        "DocFamily",
        back_populates="family",
        cascade="all, delete-orphan",
        lazy="selectin",
    )

    deliveries: Mapped[List["FamilyDelivery"]] = relationship(
        "FamilyDelivery",
        back_populates="family",
        cascade="all, delete-orphan",
        lazy="selectin",
    )

    __table_args__ = (
        CheckConstraint("length(cpf) = 11", name="check_cpf_length"),
        CheckConstraint("length(state) = 2", name="check_state_length"),
        CheckConstraint("income >= 0", name="check_income_positive"),
        Index("idx_family_cpf", "cpf"),
        Index("idx_family_situation", "situation"),
        Index("idx_family_institution", "institution_id"),
        Index("idx_family_name", "name"),
    )

    def __repr__(self) -> str:
        return f"<Family(id={self.id}, name='{self.name}', cpf='{self.cpf}', situation='{self.situation.value}')>"


class DocFamily(BaseModel):
    __tablename__ = "doc_families"

    doc_type: Mapped[str] = mapped_column(
        String(50),
        nullable=False,
        index=True,
        comment="Tipo do documento (ex: RG, comprovante de residência, etc.)",
    )
    doc_file: Mapped[bytes] = mapped_column(
        LargeBinary, nullable=False, comment="Arquivo do documento em formato binário"
    )
    file_name: Mapped[Optional[str]] = mapped_column(
        String(255), nullable=True, comment="Nome original do arquivo"
    )
    mime_type: Mapped[Optional[str]] = mapped_column(
        String(100), nullable=True, comment="Tipo MIME do arquivo"
    )

    family_id: Mapped[int] = mapped_column(
        ForeignKey("account_families.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
        comment="Família à qual o documento pertence",
    )
    family: Mapped["Family"] = relationship(
        "Family", back_populates="documents", lazy="joined"
    )

    __table_args__ = (
        Index("idx_doc_family_id", "family_id"),
        Index("idx_doc_type", "doc_type"),
    )

    def __repr__(self) -> str:
        return f"<DocFamily(id={self.id}, doc_type='{self.doc_type}', family_id={self.family_id})>"


class FamilyDelivery(BaseModel):
    __tablename__ = "family_deliveries"
    
    institution_id: Mapped[int] = mapped_column(
        ForeignKey("institutions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
        comment="ID da instituição que realizou a entrega",
    )
    
    family_id: Mapped[int] = mapped_column(
        ForeignKey("account_families.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
        comment="ID da família que recebeu a entrega",
    )
    
    account_id: Mapped[int] = mapped_column(
        ForeignKey("accounts.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    
    delivery_date: Mapped[str] = mapped_column(
        String(25), nullable=False, comment="Data e hora da entrega"
    )
    
    description: Mapped[Optional[str]] = mapped_column(
        String(500), nullable=True, comment="Descrição da entrega realizada"
    )
    
    institution: Mapped["Institution"] = relationship(
        "Institution", back_populates="deliveries", lazy="joined"
    )
    
    family: Mapped["Family"] = relationship(
        "Family", back_populates="deliveries", lazy="joined"
    )

    account: Mapped[Optional["Account"]] = relationship(
        "Account", back_populates="deliveries", lazy="joined"
    )

    __table_args__ = (
        Index("idx_family_delivery_family_id", "family_id"),
        Index("idx_family_delivery_date", "delivery_date"),
    )

    def __repr__(self) -> str:
        return f"<FamilyDelivery(id={self.id}, family_id={self.family_id}, delivery_date='{self.delivery_date}')>"
