from decimal import Decimal
from pydantic import BaseModel, ConfigDict, EmailStr, Field
from typing import List, Optional
from fastapi import Form, File, UploadFile

class UserRequest(BaseModel):
    login: str
    senha: str
    account_type: int

class UserResponse(BaseModel):
    id: int
    login: str
    account_type: str
    active: bool
    family_id: Optional[int] = None
    
    model_config = ConfigDict(from_attributes=True)

class CreateFamily:
    def __init__(
        self,
        responsavel_id: int = Form(...),
        name: str = Form(...),
        cpf: str = Form(...),
        mobile: str = Form(...),
        family_size: int = Form(...),
        address: str = Form(...),
        number: int = Form(...),
        complement: Optional[str] = Form(None),
        zipcode: str = Form(...),
        district: str = Form(...),
        city: str = Form(...),
        state: str = Form(...),
        monthly_income: Decimal = Form(...),
        description: Optional[str] = Form(None),
        situation_type: int = Form(0),
        authorized_accounts: str = Form("")
    ):
        self.responsavel_id = responsavel_id
        self.name = name
        self.cpf = cpf
        self.mobile = mobile
        self.family_size = family_size
        self.address = address
        self.number = number
        self.complement = complement
        self.zipcode = zipcode
        self.district = district
        self.city = city
        self.state = state
        self.monthly_income = monthly_income
        self.description = description
        self.situation_type = situation_type
        self.authorized_accounts = authorized_accounts

class UpdateFamily:
    def __init__(
        self,
        name: Optional[str] = Form(None),
        cpf: Optional[str] = Form(None),
        mobile: Optional[str] = Form(None),
        family_size: Optional[int] = Form(None),
        address: Optional[str] = Form(None),
        number: Optional[int] = Form(None),
        complement: Optional[str] = Form(None),
        zipcode: Optional[str] = Form(None),
        district: Optional[str] = Form(None),
        city: Optional[str] = Form(None),
        state: Optional[str] = Form(None),
        authorized_accounts: Optional[str] = Form(None),
        monthly_income: Optional[Decimal] = Form(None),
        description: Optional[str] = Form(None),
        situation_type: Optional[int] = Form(None)
    ):
        self.name = name
        self.cpf = cpf
        self.mobile = mobile
        self.family_size = family_size
        self.address = address
        self.number = number
        self.complement = complement
        self.zipcode = zipcode
        self.district = district
        self.city = city
        self.state = state
        self.authorized_accounts = authorized_accounts
        self.monthly_income = monthly_income
        self.description = description
        self.situation_type = situation_type

class Responsavel(BaseModel):
    id: int
    login: str
    account_type: str
    active: bool
    
    model_config = ConfigDict(from_attributes=True)

class AuthAccount(BaseModel):
    account_id: int
    login: Optional[str] = None
    name: Optional[str] = None
    cpf: Optional[str] = None
    kinship: Optional[str] = None
    
    model_config = ConfigDict(from_attributes=True)

class Family(BaseModel):
    id: int
    name: str
    cpf: str
    mobile: str
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
    responsavel: Optional[Responsavel] = None
    authorized_accounts: List[AuthAccount] = []

    model_config = ConfigDict(from_attributes=True)

class FileUpload(BaseModel):
    filename: str
    content_type: str
    size: int
    url: str
    
    model_config = ConfigDict(from_attributes=True)