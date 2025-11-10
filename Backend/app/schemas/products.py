from typing import Optional
from pydantic import BaseModel, ConfigDict, field_validator, Field
from datetime import datetime


class StockItemCreateForInstitution(BaseModel):
    name: str
    sku: str
    quantity: int = Field(default=0, ge=0)

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: str) -> str:
        return v.strip()

    @field_validator("sku")
    @classmethod
    def normalize_sku(cls, v: str) -> str:
        return v.upper().strip()


class StockItemUpdate(BaseModel):
    name: Optional[str] = None
    quantity: Optional[int] = Field(default=None, ge=0)

    @field_validator("name")
    @classmethod
    def normalize_name(cls, v: Optional[str]) -> Optional[str]:
        return v.strip() if v else None


class StockItemResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    institution_id: int
    name: str
    sku: str
    quantity: int


class StockHistoryResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    stock_item_id: int
    quantity: int
