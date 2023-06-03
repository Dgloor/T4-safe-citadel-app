from src.visit import router as visit_router
from fastapi import APIRouter

router = APIRouter()

router.include_router(visit_router.router, prefix="/visit", tags=["visit"])
