from fastapi import APIRouter

router = APIRouter()


@router.get("/visitor")
async def visitor():
    return {"message": "Visitor"}
