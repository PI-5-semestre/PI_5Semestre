from typing import Optional
from pydantic import BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime


class UserResp(BaseModel):

    model_config = ConfigDict(from_attributes=True)

    id: int
    created: datetime
    modified: datetime
    active: bool
    login: str
    email: str
    account_type: str
    family_id: Optional[int]


class UserReq(BaseModel):

    login: str
    email: str
    senha: str