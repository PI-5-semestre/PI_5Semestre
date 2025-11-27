import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from sqlalchemy.pool import NullPool
from app.core.settings import Settings
from app.models.users import Account
from app.models.Institutions import Institution, InstitutionType

configs = Settings()

def create_test_user(email="test@example.com", password="password"):
    sync_url = configs.DATABASE_URL.replace('+asyncpg', '')
    # NullPool é crucial aqui para não travar o banco para o próximo teste
    engine = create_engine(sync_url, poolclass=NullPool)
    
    with Session(engine) as session:
        if session.query(Account).filter_by(email=email).first():
            return # Já existe (segurança)

        institution = Institution(
            name="Test Institution",
            institution_type=InstitutionType.ONGS
        )
        session.add(institution)
        session.flush()

        account = Account(
            email=email,
            password=password, 
            active=True,
            institution_id=institution.id
        )
        session.add(account)
        session.commit()
    # Engine dispose garante fechamento TCP imediato
    engine.dispose()

def create_inactive_user(email="inactive@example.com", password="password"):
    sync_url = configs.DATABASE_URL.replace('+asyncpg', '')
    engine = create_engine(sync_url, poolclass=NullPool)
    
    with Session(engine) as session:
        if session.query(Account).filter_by(email=email).first():
            return

        institution = Institution(
            name="Test Institution Inactive",
            institution_type=InstitutionType.ONGS
        )
        session.add(institution)
        session.flush()

        account = Account(
            email=email,
            password=password, 
            active=False,  # Inactive
            institution_id=institution.id
        )
        session.add(account)
        session.commit()
    engine.dispose()

@pytest.mark.asyncio
async def test_login_success(async_client):
    create_test_user() 
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "test@example.com",
        "password": "password"
    })
    assert response.status_code == 200
    assert "token" in response.json()

@pytest.mark.asyncio
async def test_login_wrong_password(async_client):
    create_test_user()
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "test@example.com",
        "password": "WRONG_PASSWORD"
    })
    assert response.status_code == 401

@pytest.mark.asyncio
async def test_create_token_success(async_client):
    create_test_user()
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "test@example.com",
        "password": "password"
    })
    assert response.status_code == 200
    assert "token" in response.json()

@pytest.mark.asyncio
async def test_login_user_not_found(async_client):
    # Não cria usuário, tenta login com email inexistente
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "nonexistent@example.com",
        "password": "password"
    })
    assert response.status_code == 401

@pytest.mark.asyncio
async def test_login_inactive_account(async_client):
    create_inactive_user()
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "inactive@example.com",
        "password": "password"
    })
    assert response.status_code == 401

@pytest.mark.asyncio
async def test_login_email_case_insensitive(async_client):
    create_test_user(email="Test@Example.Com", password="password")
    # Login com email em minúsculo
    response = await async_client.post("/api/v1/auth/login", json={
        "email": "test@example.com",
        "password": "password"
    })
    assert response.status_code == 200
    assert "token" in response.json()