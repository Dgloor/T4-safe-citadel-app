from src import crud, models, schema
from sqlalchemy.orm import Session
from fastapi import FastAPI, Depends, HTTPException, APIRouter
from src import models, schema
from config.database import SessionLocal, engine, get_db
from fastapi.middleware.cors import CORSMiddleware

models.Base.metadata.create_all(bind=engine)

app_router = APIRouter()


@app_router.post("/api/user/", response_model=schema.User)
def create_user(user: schema.UserCreate, db: Session = Depends(get_db)):
    return crud.create_user(db=db, user=user)
