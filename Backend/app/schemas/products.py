from typing import List
from pydantic import BaseModel, ConfigDict
from datetime import datetime

class ProductResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    institution_id: int
    name: str
    sku: str
    quantity: int
    type_stock: str

class ProductCreateReq(BaseModel):
    institution_id: int
    name: str
    sku: str
    quantity: int

class ProductReq(BaseModel):
    sku: str
    quantity: int

class BasketReq(BaseModel):
    institution_id: int
    family_id: int
    products: List[ProductReq]
    