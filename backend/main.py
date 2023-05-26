from fastapi.responses import UJSONResponse
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.visitor.router import router as visitor_router

allow_all = ["*"]


app = FastAPI(
    title="Backend Safe Citle",
    description="Backend",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    penapi_url="/api/openapi.json",
    default_response_class=UJSONResponse,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_all,
    allow_credentials=True,
    allow_methods=allow_all,
    allow_headers=allow_all,
)

app.include_router(visitor_router, prefix="/api")
