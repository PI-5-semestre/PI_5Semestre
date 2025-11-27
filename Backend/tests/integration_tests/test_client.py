import pytest
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text
from app.core.settings import Settings

configs = Settings()

@pytest.mark.asyncio
async def test_database_connection():
    engine = create_async_engine(configs.DATABASE_URL)
    
    async with engine.begin() as conn:
        result = await conn.execute(text("SELECT 1"))
        assert result.scalar() == 1
    
    await engine.dispose()