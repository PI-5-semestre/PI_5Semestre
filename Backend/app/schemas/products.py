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

class ProductReq(BaseModel):
    institution_id: int
    name: str
    sku: str
    quantity: int
    