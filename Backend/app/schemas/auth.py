from pydantic import BaseModel, ConfigDict
from app.schemas.users import UserResp


class AuthReq(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    login: str
    password: str
    

class AuthResp(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    account: UserResp
    token: str