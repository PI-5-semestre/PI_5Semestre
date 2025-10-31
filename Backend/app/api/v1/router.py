from fastapi import APIRouter
from app.api.v1.endpoints.families import router as families_router
from app.api.v1.endpoints.Institutions import router as institutions_router
from app.api.v1.endpoints.products import router as products_router
from app.api.v1.endpoints.users import router as users_router
from app.api.v1.endpoints.auth import router as auths_router

routers = APIRouter()

router_list = [families_router, institutions_router, products_router, users_router, auths_router]

for router in router_list:
    router.tags = ["v1"] + (router.tags)
    routers.include_router(router)