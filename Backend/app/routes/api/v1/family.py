import os
import uuid
import re 
import json
from http import HTTPStatus
from typing import Annotated, List, Optional
from fastapi import APIRouter, Depends, HTTPException, File, UploadFile
from sqlalchemy import select, func, insert
from sqlalchemy.orm import selectinload
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import IntegrityError
from decimal import Decimal
from app.core.database import get_session
from app.schemas.schemas import Family as FamilySchema, CreateFamily, UpdateFamily
from app.models.models import Account, Family, SituationType, KinshipType, family_authorized_accounts, FamilyClosure

UPLOAD_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "media", "proof_address")
os.makedirs(UPLOAD_DIR, exist_ok=True)

router = APIRouter(prefix='/family', tags=['Family'])
Session = Annotated[AsyncSession, Depends(get_session)]

@router.post('/', response_model=FamilySchema, status_code=HTTPStatus.CREATED)
async def create(
    db: Session,
    family_data: CreateFamily = Depends(),
    proof_address: Optional[UploadFile] = File(None)
):
    try:
        clean_cpf = lambda cpf: re.sub(r'[^\d]', '', cpf)
        get_situation_type = lambda st: SituationType.PENDING if st == 0 else SituationType.ACTIVE
        
        file_path = relative_url = file_size = None
        if proof_address:
            file_ext = os.path.splitext(proof_address.filename)[1]
            unique_filename = f"{uuid.uuid4()}{file_ext}"
            file_path = os.path.join(UPLOAD_DIR, unique_filename)
            
            with open(file_path, "wb") as f:
                content = await proof_address.read()
                f.write(content)
            
            file_size = os.path.getsize(file_path)
            relative_url = f"/media/proof_address/{unique_filename}"
        
        new_family = Family(
            responsavel_id=family_data.responsavel_id,
            name=family_data.name,
            cpf=clean_cpf(family_data.cpf),
            mobile=family_data.mobile,
            family_size=family_data.family_size,
            address=family_data.address,
            number=str(family_data.number),
            complement=family_data.complement,
            zipcode=family_data.zipcode,
            district=family_data.district,
            city=family_data.city,
            state=family_data.state,
            monthly_income=Decimal(str(family_data.monthly_income)),
            description=family_data.description,
            situation_type=get_situation_type(family_data.situation_type),
        )
        
        db.add(new_family)
        await db.flush()
        
        await db.execute(
            insert(FamilyClosure).values(
                ancestor_id=new_family.id,
                descendant_id=new_family.id,
                depth=0
            )
        )
        
        if family_data.authorized_accounts:
            try:
                accounts_data = json.loads(family_data.authorized_accounts)
                
                for account_data in accounts_data:
                    account_id = account_data.get('account_id')
                    
                    if account_id == family_data.responsavel_id:
                        continue
                    
                    account = await db.scalar(select(Account).where(Account.id == account_id))
                    if not account:
                        raise HTTPException(
                            status_code=HTTPStatus.BAD_REQUEST,
                            detail="Conta não encontrada."
                        )
                    
                    count = await db.scalar(
                        select(func.count()).select_from(family_authorized_accounts)
                        .where(family_authorized_accounts.c.family_id == new_family.id)
                    )
                    if count >= 2:
                        raise HTTPException(
                            status_code=HTTPStatus.BAD_REQUEST,
                            detail="Limite de contas autorizadas excedido."
                        )
                    
                    kinship_value = None
                    kinship_str = account_data.get('kinship')
                    if kinship_str:
                        try:
                            kinship_value = KinshipType(kinship_str)
                        except ValueError:
                            raise HTTPException(
                                status_code=HTTPStatus.BAD_REQUEST,
                                detail="Tipo de parentesco inválido."
                            )
                    
                    insert_data = {
                        "family_id": new_family.id,
                        "account_id": account.id,
                        "active": True,
                        "login": account.login,
                        "name": account_data.get('name'),
                        "cpf": clean_cpf(account_data.get('cpf', '')),
                        "kinship": kinship_value.value if kinship_value else None
                    }
                    
                    await db.execute(family_authorized_accounts.insert().values(**insert_data))
                    
            except json.JSONDecodeError:
                raise HTTPException(
                    status_code=HTTPStatus.BAD_REQUEST,
                    detail="Formato inválido para contas autorizadas."
                )
        
        if proof_address and file_path:
            new_family.set_proof_address(
                filename=proof_address.filename,
                file_path=file_path,
                file_url=relative_url,
                file_size=file_size,
                content_type=proof_address.content_type
            )
        
        await db.commit()
        await db.refresh(new_family)
        
        new_family.responsavel = await db.scalar(
            select(Account).where(Account.id == new_family.responsavel_id)
        )
        new_family.authorized_accounts = await new_family.get_authorized_accounts_with_details(db)
        
        return new_family
        
    except HTTPException:
        await db.rollback()
        raise
    except IntegrityError:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail="CPF já cadastrado no sistema."
        )
    except Exception:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Erro interno do servidor."
        )
    
@router.put('/{family_id}', response_model=FamilySchema, status_code=HTTPStatus.OK)
async def update(
    family_id: int,
    db: Session,
    family_data: UpdateFamily = Depends(),
    proof_address: Optional[UploadFile] = File(None)
):
    try:
        clean_cpf = lambda cpf: re.sub(r'[^\d]', '', cpf)
        get_situation_type = lambda st: SituationType.PENDING if st == 0 else SituationType.ACTIVE
        
        family = await db.scalar(select(Family).where(Family.id == family_id))
        if not family:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail="Família não encontrada."
            )
        
        field_mappings = [
            ('name', 'name'),
            ('cpf', 'cpf', clean_cpf),
            ('mobile', 'mobile'),
            ('family_size', 'family_size'),
            ('address', 'address'),
            ('number', 'number', str),
            ('complement', 'complement'),
            ('zipcode', 'zipcode'),
            ('district', 'district'),
            ('city', 'city'),
            ('state', 'state'),
            ('monthly_income', 'monthly_income', lambda x: Decimal(str(x))),
            ('description', 'description'),
            ('situation_type', 'situation_type', get_situation_type),
        ]
        
        for field_name, attr_name, *transform in field_mappings:
            value = getattr(family_data, field_name, None)
            if value is not None:
                if transform:
                    value = transform[0](value)
                setattr(family, attr_name, value)
        
        if proof_address is not None:
            current_proof = getattr(family, 'proof_address', None)
            same_file = False
            
            if current_proof and current_proof.get('filename') == proof_address.filename:
                file_content = await proof_address.read()
                if current_proof.get('size') == len(file_content):
                    same_file = True
                await proof_address.seek(0)
            
            if not same_file:
                file_ext = os.path.splitext(proof_address.filename)[1]
                unique_filename = f"{uuid.uuid4()}{file_ext}"
                file_path = os.path.join(UPLOAD_DIR, unique_filename)
                
                with open(file_path, "wb") as f:
                    content = await proof_address.read()
                    f.write(content)
                
                file_size = os.path.getsize(file_path)
                relative_url = f"/media/proof_address/{unique_filename}"
                
                family.set_proof_address(
                    filename=proof_address.filename,
                    file_path=file_path,
                    file_url=relative_url,
                    file_size=file_size,
                    content_type=proof_address.content_type
                )
        
        if family_data.authorized_accounts is not None:
            try:
                accounts_data = json.loads(family_data.authorized_accounts)
                
                await db.execute(
                    family_authorized_accounts.delete().where(
                        family_authorized_accounts.c.family_id == family.id
                    )
                )
                
                for account_data in accounts_data:
                    account_id = account_data.get('account_id')
                    
                    if account_id == family.responsavel_id:
                        continue
                    
                    account = await db.scalar(select(Account).where(Account.id == account_id))
                    if not account:
                        raise HTTPException(
                            status_code=HTTPStatus.BAD_REQUEST,
                            detail="Conta não encontrada."
                        )
                    
                    count = await db.scalar(
                        select(func.count()).select_from(family_authorized_accounts)
                        .where(family_authorized_accounts.c.family_id == family.id)
                    )
                    if count >= 2:
                        raise HTTPException(
                            status_code=HTTPStatus.BAD_REQUEST,
                            detail="Limite de contas autorizadas excedido."
                        )
                    
                    kinship_value = None
                    kinship_str = account_data.get('kinship')
                    if kinship_str:
                        try:
                            kinship_value = KinshipType(kinship_str)
                        except ValueError:
                            raise HTTPException(
                                status_code=HTTPStatus.BAD_REQUEST,
                                detail="Tipo de parentesco inválido."
                            )
                    
                    insert_data = {
                        "family_id": family.id,
                        "account_id": account.id,
                        "active": True,
                        "login": account.login,
                        "name": account_data.get('name'),
                        "cpf": clean_cpf(account_data.get('cpf', '')),
                        "kinship": kinship_value.value if kinship_value else None
                    }
                    
                    await db.execute(family_authorized_accounts.insert().values(**insert_data))
                
            except json.JSONDecodeError:
                raise HTTPException(
                    status_code=HTTPStatus.BAD_REQUEST,
                    detail="Formato inválido para contas autorizadas."
                )
        
        await db.commit()
        await db.refresh(family)
        
        family.responsavel = await db.scalar(
            select(Account).where(Account.id == family.responsavel_id)
        )
        family.authorized_accounts = await family.get_authorized_accounts_with_details(db)
        
        return family
        
    except HTTPException:
        await db.rollback()
        raise
    except IntegrityError:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail="CPF já cadastrado no sistema."
        )
    except Exception:
        await db.rollback()
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Erro interno do servidor."
        )

@router.get('/', response_model=List[FamilySchema], status_code=HTTPStatus.OK)
async def list_all(db: Session):
    try:
        families = await db.scalars(
            select(Family)
            .options(selectinload(Family.responsavel))
            .order_by(Family.created.asc())
        )
        
        for family in families:
            family.authorized_accounts = await family.get_authorized_accounts_with_details(db)
        
        return families.all()
    
    except Exception:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Erro interno do servidor."
        )

@router.get('/{family_id}', response_model=FamilySchema)
async def get_by_id(family_id: int, db: Session):
    try:
        family = await db.scalar(
            select(Family)
            .options(selectinload(Family.responsavel))
            .where(Family.id == family_id)
        )
        
        if not family:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail="Família não encontrada."
            )
        
        family.authorized_accounts = await family.get_authorized_accounts_with_details(db)
        return family
    
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Erro interno do servidor."
        )

async def get_auth_accounts(db: Session, family_id: int) -> List[dict]:
    auth_accounts_query = (
        select(
            Account.id,
            Account.login,
            family_authorized_accounts.c.name,
            family_authorized_accounts.c.cpf,
            family_authorized_accounts.c.kinship
        )
        .select_from(family_authorized_accounts.join(Account))
        .where(family_authorized_accounts.c.family_id == family_id)
    )
    
    auth_result = await db.execute(auth_accounts_query)
    auth_accounts = auth_result.mappings().all()
    
    return [
        {
            "id": f"auth_{acc['id']}",
            "name": acc["name"] or acc["login"],
            "login": acc["login"], 
            "cpf": acc["cpf"],
            "kinship": acc["kinship"] if acc["kinship"] else None,
            "children": []
        }
        for acc in auth_accounts
    ]

async def build_tree_recursive(db, family_id, depth=0, max_depth=5):
    if depth >= max_depth:
        return {"id": family_id, "name": "...", "children": []}
        
    family_query = select(Family).where(Family.id == family_id)
    family_result = await db.execute(family_query)
    family = family_result.scalars().first()
    
    if not family:
        return {"id": family_id, "name": "Unknown", "children": []}
    
    responsavel_query = select(Account).where(Account.id == family.responsavel_id)
    responsavel_result = await db.execute(responsavel_query)
    responsavel = responsavel_result.scalars().first()
    
    authorized_children = await get_auth_accounts(db, family_id)
    
    children_query = (
        select(Family)
        .join(FamilyClosure, Family.id == FamilyClosure.descendant_id)
        .where(FamilyClosure.ancestor_id == family_id)
        .where(FamilyClosure.depth == 1)
    )
    
    children_result = await db.execute(children_query)
    children_data = children_result.scalars().all()
    
    family_children = []
    for child in children_data:
        child_tree = await build_tree_recursive(db, child.id, depth + 1, max_depth)
        family_children.append(child_tree)
    
    return {
        "id": family.id,
        "name": family.name,
        "cpf": family.cpf,
        "responsavel_login": responsavel.login if responsavel else None,
        "children": authorized_children + family_children
    }

@router.get('/{family_id}/tree', response_model=dict)
async def get_tree(family_id: int, db: Session):
    try:
        family_query = select(Family).where(Family.id == family_id)
        family_result = await db.execute(family_query)
        family = family_result.scalars().first()
        
        if not family:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail="Família não encontrada."
            )
        
        responsavel_query = select(Account).where(Account.id == family.responsavel_id)
        responsavel_result = await db.execute(responsavel_query)
        responsavel = responsavel_result.scalars().first()
        
        if not responsavel:
            raise HTTPException(
                status_code=HTTPStatus.NOT_FOUND,
                detail="Responsável não encontrado."
            )
        
        auth_accounts_query = (
            select(
                Account.id,
                Account.login,
                family_authorized_accounts.c.name,
                family_authorized_accounts.c.cpf,
                family_authorized_accounts.c.kinship
            )
            .select_from(family_authorized_accounts.join(Account))
            .where(family_authorized_accounts.c.family_id == family_id)
        )
        
        auth_result = await db.execute(auth_accounts_query)
        auth_accounts = auth_result.mappings().all()
        
        tree = {
            "id": responsavel.id,
            "name": family.name,
            "login": responsavel.login,
            "children": [
                {
                    "id": acc["id"],
                    "name": acc["name"] or acc["login"],
                    "login": acc["login"],
                    "cpf": acc["cpf"],
                    "kinship": acc["kinship"] if acc["kinship"] else None,
                }
                for acc in auth_accounts
            ]
        }
        
        return tree
        
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Erro interno do servidor."
        )