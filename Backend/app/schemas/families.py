from decimal import Decimal
from typing import List, Optional
from pydantic import BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime

# datetime ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

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
    benefit_expiration_date: Optional[datetime] = None
    accounts: Optional[List["ParticipantesResp"]] = None
    visits: Optional[List["VisitResp"]] = None

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
    
class ParticipantesResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    login: str
    family_id: Optional[int] = None
    institution_id: Optional[int] = None
    account_type: str

class BeneficitReq(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    
class VisitReq(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    
    day_visit: datetime
    id_family: int
    
class VisitResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    visit_date: datetime
    attempt_count: int