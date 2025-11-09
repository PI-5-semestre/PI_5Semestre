from typing import Optional
from pydantic import BaseModel, ConfigDict, EmailStr, Field, field_validator
from datetime import datetime


class ProfileSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    cpf: str
    mobile: str


class UserBase(BaseModel):
    email: EmailStr = Field(..., description="Email do usuário")
    name: str = Field(..., min_length=3, max_length=200, description="Nome completo")
    cpf: str = Field(..., pattern=r"^\d{11}$", description="CPF com 11 dígitos")
    mobile: str = Field(..., pattern=r"^\d{10,15}$", description="Telefone celular")

    @field_validator("email")
    @classmethod
    def normalize_email(cls, v: str) -> str:
        return v.lower().strip()

    @field_validator("cpf")
    @classmethod
    def validate_cpf(cls, v: str) -> str:
        return v.strip() if v else None

    @field_validator("mobile")
    @classmethod
    def normalize_mobile(cls, v: str) -> str:
        return v.strip() if v else None


class UserCreate(UserBase):
    password: str = Field(
        ..., min_length=6, max_length=100, description="Senha do usuário"
    )
    account_type: Optional[str] = Field(
        default="VOLUNTEER",
        description="Tipo de conta: OWNER, DELIVERY_MAN, ADMINISTRATIVE, ASSISTANT, VOLUNTEER",
    )
    institution_id: int = Field(..., gt=0, description="ID da instituição")


class UserUpdate(BaseModel):
    email: Optional[EmailStr] = Field(None, description="Email do usuário")
    password: Optional[str] = Field(
        None, min_length=6, max_length=100, description="Nova senha"
    )
    name: Optional[str] = Field(
        None, min_length=3, max_length=200, description="Nome completo"
    )
    cpf: Optional[str] = Field(
        None, pattern=r"^\d{11}$", description="CPF com 11 dígitos"
    )
    mobile: Optional[str] = Field(
        None, pattern=r"^\d{10,15}$", description="Telefone celular"
    )
    account_type: Optional[str] = Field(
        None,
        description="Tipo de conta: OWNER, DELIVERY_MAN, ADMINISTRATIVE, ASSISTANT, VOLUNTEER",
    )
    institution_id: Optional[int] = Field(None, gt=0, description="ID da instituição")

    @field_validator("email")
    @classmethod
    def normalize_email(cls, v: Optional[str]) -> Optional[str]:
        return v.lower().strip() if v else None

    @field_validator("cpf")
    @classmethod
    def validate_cpf(cls, v: Optional[str]) -> Optional[str]:
        return v.strip() if v else None

    @field_validator("mobile")
    @classmethod
    def normalize_mobile(cls, v: Optional[str]) -> Optional[str]:
        return v.strip() if v else None


class UserResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    email: str
    account_type: str
    institution_id: Optional[int] = None
    profile: Optional[ProfileSchema] = None


UserReq = UserCreate
