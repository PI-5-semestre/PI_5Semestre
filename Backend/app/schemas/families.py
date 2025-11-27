from decimal import Decimal
from typing import List, Optional
from pydantic import BaseModel, ConfigDict, field_validator, Field
from datetime import datetime
from app.models.families import SituationType, DegreeOfKinship


class FamilyCreateForInstitution(BaseModel):
    name: str
    cpf: str = Field(..., min_length=11, max_length=11)
    mobile_phone: str
    zip_code: str = Field(..., min_length=8, max_length=9)
    street: str
    number: str
    neighborhood: str
    state: str = Field(..., min_length=2, max_length=2)
    city: Optional[str] = None
    income: Decimal = Field(default=Decimal("0.00"), ge=0)
    description: Optional[str] = None

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: str) -> str:
        return v.strip().upper()

    @field_validator("cpf")
    @classmethod
    def normalize_cpf(cls, v: str) -> str:
        return v.strip().replace(".", "").replace("-", "")

    @field_validator("mobile_phone")
    @classmethod
    def normalize_mobile(cls, v: str) -> str:
        return (
            v.strip()
            .replace("(", "")
            .replace(")", "")
            .replace("-", "")
            .replace(" ", "")
        )

    @field_validator("zip_code")
    @classmethod
    def normalize_zip_code(cls, v: str) -> str:
        return v.strip().replace("-", "")

    @field_validator("state")
    @classmethod
    def normalize_state(cls, v: str) -> str:
        return v.strip().upper()


class FamilyMemberCreate(BaseModel):
    id: Optional[int] = None
    name: Optional[str]
    cpf: Optional[str] = Field(None, min_length=11, max_length=11)
    kinship: Optional[DegreeOfKinship] = None
    can_receive: Optional[bool] = False

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: Optional[str]) -> Optional[str]:
        return v.strip().upper() if v else None

    @field_validator("cpf")
    @classmethod
    def normalize_cpf(cls, v: Optional[str]) -> Optional[str]:
        return v.strip().replace(".", "").replace("-", "") if v else None



class FamilyMemberResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    name: str
    cpf: Optional[str]
    kinship: DegreeOfKinship
    family_id: int
    can_receive: bool

class FamilyUpdate(BaseModel):
    name: Optional[str] = None
    mobile_phone: Optional[str] = None
    zip_code: Optional[str] = Field(default=None, min_length=8, max_length=9)
    street: Optional[str] = None
    number: Optional[str] = None
    neighborhood: Optional[str] = None
    state: Optional[str] = Field(default=None, min_length=2, max_length=2)
    city: Optional[str] = None
    income: Optional[Decimal] = Field(default=None, ge=0)
    description: Optional[str] = None
    situation: Optional[SituationType] = None
    members : Optional[List[FamilyMemberCreate]] = None
    
    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: Optional[str]) -> Optional[str]:
        return v.strip().upper() if v else None

    @field_validator("mobile_phone")
    @classmethod
    def normalize_mobile(cls, v: Optional[str]) -> Optional[str]:
        return (
            v.strip()
            .replace("(", "")
            .replace(")", "")
            .replace("-", "")
            .replace(" ", "")
            if v
            else None
        )

    @field_validator("zip_code")
    @classmethod
    def normalize_zip_code(cls, v: Optional[str]) -> Optional[str]:
        return v.strip().replace("-", "") if v else None

    @field_validator("state")
    @classmethod
    def normalize_state(cls, v: Optional[str]) -> Optional[str]:
        return v.strip().upper() if v else None


class FamilyResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    name: str
    cpf: str
    mobile_phone: str
    zip_code: str
    street: str
    number: str
    neighborhood: str
    state: str
    city: Optional[str] = None
    situation: str
    income: Decimal
    description: Optional[str]
    institution_id: int
    members: Optional[List[FamilyMemberResp]] = None


class DocFamilyCreate(BaseModel):
    doc_type: str
    file_name: str
    mime_type: str

    @field_validator("doc_type")
    @classmethod
    def normalize_doc_type(cls, v: str) -> str:
        return v.strip().upper()


class DocFamilyResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    doc_type: str
    file_name: Optional[str]
    mime_type: Optional[str]
    family_id: int
