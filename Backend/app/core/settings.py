import os
from pydantic_settings import BaseSettings, SettingsConfigDict
from dotenv import load_dotenv

load_dotenv()


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", case_sensitive=True
    )

    API_V1_STR: str = "/api/v1"
    PROJECT_ROOT: str = os.path.dirname(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    )

    DATETIME_FORMAT: str = "%Y-%m-%dT%H:%M:%S"
    DATE_FORMAT: str = "%Y-%m-%d"

    PROJECT_NAME: str = "cesta-api"
    DATABASE_URL: str
    SECRET_KEY: str
    ALGORITHM: str

    DEFAULT_PAGE_SIZE: int = 20
    MAX_PAGE_SIZE: int = 100
    MIN_PAGE_SIZE: int = 1
    DEFAULT_SKIP: int = 0

    ALLOWED_MIME_TYPES: str = "application/pdf,image/png,image/jpeg,image/jpg"
    MAX_FILE_SIZE_MB: int = 5
