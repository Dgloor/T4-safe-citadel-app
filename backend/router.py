from src.auth import router as auth_router
from fastapi import APIRouter

router = APIRouter()
router.include_router(auth_router.router, prefix="/api/auth", tags=["auth"])
