from fastapi import FastAPI
from app.api.v1.router import routers as v1_routers
from app.util.class_object import singleton
from app.core.settings import Settings

from app.models.users import Account
from app.models.families import Family
from app.models.Institutions import Institution
from app.models.products import StockItem, StockHistory

configs = Settings()


@singleton
class AppCreator:
    def __init__(self):
        self.app = FastAPI(
            title=configs.PROJECT_NAME,
            openapi_url=f"{configs.API_V1_STR}/openapi.json",
            version="0.0.1",
        )

        @self.app.get("/")
        def root():
            return "service is working"

        self.app.include_router(v1_routers, prefix=configs.API_V1_STR)


app_creator = AppCreator()
app = app_creator.app
