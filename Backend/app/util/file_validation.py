from fastapi import UploadFile
from app.core.settings import Settings

settings = Settings()

ALLOWED_MIME_TYPES = set(settings.ALLOWED_MIME_TYPES.split(","))
MAX_FILE_SIZE = settings.MAX_FILE_SIZE_MB * 1024 * 1024

async def validate_file_upload(file: UploadFile) -> bytes:
    
    if file.content_type not in ALLOWED_MIME_TYPES:
        raise ValueError(
            f"File type not allowed. Allowed types: {', '.join(ALLOWED_MIME_TYPES)}"
        )
    
    file_content = await file.read()
    
    if len(file_content) > MAX_FILE_SIZE:
        raise ValueError(
            f"File too large. Maximum size: {settings.MAX_FILE_SIZE_MB}MB"
        )
    
    return file_content
