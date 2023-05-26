from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse
import models
import dependencies
import logging

router = APIRouter()


@router.post("/signup", include_in_schema=False)
async def signup(user: models.User):
    try:
        user = dependencies.create_user(user)
        return JSONResponse(
            content={"message": "User created successfully", "user": user},
            status_code=201,
        )
    except:
        return JSONResponse(content={"message": "Error creating User"}, status_code=400)


@router.post("/login", include_in_schema=False)
async def login(user: models.User):
    try:
        jwt = dependencies.get_user(user)
        return JSONResponse(
            content={"message": "User logged successfully", "token": jwt},
            status_code=200,
        )
    except:
        return JSONResponse(content={"message": "Error logging User"}, status_code=400)


@router.post("/ping", include_in_schema=False)
async def validate(request: Request):
    headers = request.headers
    jwt = headers.get("Authorization")
    logging.info(jwt)
    user = dependencies.verify_id_token(jwt)
    return user
