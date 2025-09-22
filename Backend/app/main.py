from fastapi import FastAPI
from app.routes.api.v1.user import router as user_router
from app.routes.api.v1.family import router as family_router

app = FastAPI()

app.include_router(user_router)
app.include_router(family_router)

@app.get('/')
def read_root():
    return {'message': 'Olá Mundo!'}