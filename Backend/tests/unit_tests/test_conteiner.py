import pytest
import pytest_asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy import text

@pytest.mark.asyncio
async def test_database_connection():
    database_url = "postgresql+asyncpg://basket:25385d3659bf9c41cfb94b5d823fdaf4@localhost:5433/basket_test"
    engine = create_async_engine(database_url)
    
    async with engine.begin() as conn:
        result = await conn.execute(text("SELECT 1"))
        assert result.scalar() == 1
    
    await engine.dispose()
