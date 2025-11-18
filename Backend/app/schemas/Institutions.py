from typing import Optional
from pydantic import BaseModel, ConfigDict, field_validator
from datetime import datetime


class InstitutionCreate(BaseModel):
    name: str
    institution_type: str

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: str) -> str:
        return v.strip()

    @field_validator("institution_type")
    @classmethod
    def normalize_type(cls, v: str) -> str:
        return v.upper().strip()


class InstitutionUpdate(BaseModel):
    name: Optional[str] = None
    institution_type: Optional[str] = None

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: Optional[str]) -> Optional[str]:
        return v.strip() if v else None

    @field_validator("institution_type")
    @classmethod
    def normalize_type(cls, v: Optional[str]) -> Optional[str]:
        return v.upper().strip() if v else None


class InstitutionResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    name: str
    institution_type: str


class DeliveryCreate(BaseModel):
    family_id: int
    date: datetime
    account_id: int
    description: Optional[str] = None

class DeliveryPut(BaseModel):
    date: datetime
    account_id: int
    description: Optional[str] = None

class DeliveryResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    active: bool
    created: datetime
    institution_id: int
    family_id: int
    delivery_date: str
    account_id: int
    description: Optional[str] = None