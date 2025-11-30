from typing import List, Optional
from pydantic import BaseModel, ConfigDict, field_validator
from datetime import datetime

from app.schemas.families import FamilyResp
from app.schemas.products import CreateProductBasketItem, StockItemCreateForInstitution
from app.schemas.users import UserResp


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
    status: str
class DeliveryReschedule(BaseModel):
    new_date: datetime
    account_id: int
    description: Optional[str] = None

class DeliveryAttemptResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    active: bool
    created: datetime
    family_delivery_id: int
    status: str
    attempt_date: str
    description: Optional[str] = None


class DeliveryResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    active: bool
    created: datetime
    institution_id: int
    family_id: int
    delivery_date: str
    delivery_at : Optional[str] = None
    account_id: int
    description: Optional[str] = None
    status: str
    family: Optional["FamilyResp"] = None
    attempts: Optional[List[DeliveryAttemptResp]] = None
    
    
class UserCorporateResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    user: UserResp
    
class VisitationCreate(BaseModel):
    account_id: int
    visit_at: str
    description: Optional[str] = None
    type_of_visit: str
    
class VisitationCreateReturn(BaseModel):
    visitation_id: int
    description: str
    status: str
    
class VisitationResponseReturn(BaseModel):
    visitation_id: int
    description: str
    status: str
    
class VisitationUpdate(BaseModel):
    visit_at: Optional[str] = None
    description: Optional[str] = None
    type_of_visit: Optional[str] = None
    
class VisitationResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    active: bool
    created: datetime
    institution_id: int
    account_id: int
    family_id: Optional[int]
    visit_at: str
    description: Optional[str] = None
    type_of_visit: str
    response: Optional[VisitationResponseReturn] = None
    family: Optional["FamilyResp"] = None
    
class BasketCreateForInstitution(BaseModel):
    family_id: int
    type: str
    products: List[CreateProductBasketItem]


class BasketRespItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    
    product_sku: str
    quantity: int
    
class BasketResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    institution_id: int
    family_id: int
    basket_type: str
    products: List[BasketRespItem]