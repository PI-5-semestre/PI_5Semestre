from sqlalchemy import String, ForeignKey, Index, Enum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from enum import Enum as PyEnum
from typing import Optional, TYPE_CHECKING
from .base_modal import BaseModel

if TYPE_CHECKING:
    from .Institutions import Institution


class AccountType(PyEnum):
    OWNER = "OWNER"
    DELIVERY_MAN = "DELIVERY_MAN"
    ADMINISTRATIVE = "ADMINISTRATIVE"
    ASSISTANT = "ASSISTANT"
    VOLUNTEER = "VOLUNTEER"
    UNDEFINED = "UNDEFINED"


class Account(BaseModel):
    __tablename__ = "accounts"

    email: Mapped[str] = mapped_column(
        String(255), nullable=False, unique=True, index=True
    )
    password: Mapped[str] = mapped_column(String(255), nullable=False)

    account_type: Mapped[AccountType] = mapped_column(
        Enum(AccountType, native_enum=False),
        nullable=False,
        default=AccountType.VOLUNTEER,
    )

    institution_id: Mapped[Optional[int]] = mapped_column(
        ForeignKey("institutions.id"), nullable=False
    )

    profile: Mapped[Optional["Profile"]] = relationship(
        "Profile", back_populates="account", uselist=False, cascade="all, delete-orphan"
    )

    institution: Mapped[Optional["Institution"]] = relationship(
        "Institution", back_populates="accounts"
    )

    __table_args__ = (
        Index("idx_accounts_email", "email"),
        Index("idx_accounts_institution", "institution_id"),
    )

    def __repr__(self):
        return f"<Account(id={self.id}, email='{self.email}', type='{self.account_type.value}')>"


class Profile(BaseModel):
    __tablename__ = "profiles"

    name: Mapped[str] = mapped_column(String(200), nullable=False)
    cpf: Mapped[str] = mapped_column(
        String(11), nullable=False, unique=True, index=True
    )
    mobile: Mapped[str] = mapped_column(String(15), nullable=False)

    account_id: Mapped[Optional[int]] = mapped_column(
        ForeignKey("accounts.id", ondelete="CASCADE"), nullable=True, unique=True
    )

    account: Mapped[Optional["Account"]] = relationship(
        "Account", back_populates="profile"
    )

    __table_args__ = (
        Index("idx_profiles_cpf", "cpf"),
        Index("idx_profiles_account", "account_id"),
    )

    def __repr__(self):
        return f"<Profile(id={self.id}, name='{self.name}', cpf='{self.cpf}')>"
