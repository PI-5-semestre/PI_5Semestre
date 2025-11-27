import os
import pytest
import subprocess
from typing import AsyncGenerator
from httpx import AsyncClient, ASGITransport
from sqlalchemy import create_engine
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.pool import NullPool

# --- Configuração de Ambiente ---
os.environ["ENV"] = "test"
# Ajuste a porta conforme seu docker-compose (no log parecia 5433)
os.environ["DATABASE_URL"] = "postgresql+asyncpg://basket:25385d3659bf9c41cfb94b5d823fdaf4@localhost:5433/basket_test"

if os.getenv("ENV") != "test":
    pytest.exit(f"ENV is not test, it is {os.getenv('ENV')}")

from app.core.settings import Settings
from app.main import AppCreator
from app.models.base_modal import Base
from app.core.database import get_session

configs = Settings()

# --- 1. Utilitários e Setup do Docker ---
def run_reset_db():
    """Função síncrona pura para resetar o banco."""
    sync_url = configs.DATABASE_URL.replace('+asyncpg', '')
    # Usamos NullPool aqui também para garantir que a conexão feche imediatamente
    engine = create_engine(sync_url, poolclass=NullPool)
    
    with engine.begin() as conn:
        Base.metadata.drop_all(conn)
        Base.metadata.create_all(conn)
    engine.dispose()

@pytest.fixture(scope="session", autouse=True)
def start_docker_compose():
    """Sobe o banco apenas uma vez para toda a bateria de testes."""
    subprocess.run(["docker", "compose", "-f", "docker-compose.test.yml", "up", "-d", "--wait"], check=True)
    yield
    # subprocess.run(["docker", "compose", "-f", "docker-compose.test.yml", "down"], check=True)

# --- 2. Fixtures de Banco (Escopo de Função) ---

@pytest.fixture(scope="function")
def setup_db():
    """
    Limpa o banco ANTES de qualquer engine/sessão ser criada para o teste.
    Isso evita erros de tabela inexistente ou dados sujos.
    """
    run_reset_db()

@pytest.fixture(scope="function")
async def async_engine(setup_db):
    """
    Cria a engine NO MESMO LOOP do teste atual.
    Depende de setup_db para garantir banco limpo.
    """
    engine = create_async_engine(
        configs.DATABASE_URL,
        poolclass=NullPool, # Desativa pool para evitar conexões presas entre testes
        echo=False
    )
    yield engine
    await engine.dispose()

@pytest.fixture(scope="function")
async def db_session(async_engine) -> AsyncGenerator[AsyncSession, None]:
    """Cria a sessão para o teste e para injetar no App."""
    async_session = async_sessionmaker(async_engine, expire_on_commit=False)
    
    async with async_session() as session:
        yield session

# --- 3. Cliente HTTP (Escopo de Função) ---

@pytest.fixture(scope="function")
async def async_client(db_session) -> AsyncGenerator[AsyncClient, None]:
    """
    Cliente com Override de dependência já aplicado.
    """
    app_creator = AppCreator()
    app = app_creator.app
    
    # Override: Força o app a usar a MESMA sessão que o teste criou
    app.dependency_overrides[get_session] = lambda: db_session
    
    transport = ASGITransport(app=app)
    
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
        
    app.dependency_overrides.clear()