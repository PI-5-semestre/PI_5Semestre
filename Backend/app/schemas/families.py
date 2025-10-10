from decimal import Decimal
from typing import Optional
from pydantic import BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime


class FamilyResp(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    owner_id: int
    family_size: int
    address: str
    number: str
    complement: Optional[str]
    zipcode: str
    district: str
    city: str
    state: str
    proof_address_verificed: bool
    monthly_income: Decimal
    description: Optional[str]
    situation_type: str
    membership_id: int


class FamilyReq(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    owner_id: int
    family_size: int
    address: str
    number: str
    complement: Optional[str] = None
    zipcode: str
    district: str
    city: str
    state: str
    monthly_income: Decimal
    description: Optional[str] = None
    situation_type: str
    membership_id: int
