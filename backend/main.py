"""
Main file for the backend
"""
from fastapi.responses import UJSONResponse
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from dependencies import get_user_token
from fastapi import Request
from fastapi.responses import JSONResponse

allow_all = ["*"]

app = FastAPI(
    title="Backend Safe Citle",
    description="Backend",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    penapi_url="/api/openapi.json",
    default_response_class=UJSONResponse,
    # dependencies=[
    #     Depends(get_user_token),
    # ],
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_all,
    allow_credentials=True,
    allow_methods=allow_all,
    allow_headers=allow_all,
)


@app.get(
    "/user",
)
async def get_user(request: Request):
    """
    Get the user from the request
    """
    return JSONResponse({"user": request.state.user})
