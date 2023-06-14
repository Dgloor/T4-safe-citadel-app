from src import crud, models, schema
from sqlalchemy.orm import Session
from fastapi import FastAPI, Depends, HTTPException, APIRouter
from src import models, schema
from config.database import SessionLocal, engine, get_db
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime

models.Base.metadata.create_all(bind=engine)

app_router = APIRouter()


@app_router.post("/api/user/", response_model=schema.User, tags=["User"])
def create_user(user: schema.UserCreate, db: Session = Depends(get_db)):
    return crud.create_user(db=db, user=user)


@app_router.get("/api/user/{user_id}", response_model=schema.User, tags=["User"])
def get_user(user_id: str, db: Session = Depends(get_db)):
    db_user = crud.get_user(db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user


@app_router.post("/api/visit/", response_model=schema.Visit, tags=["Visit"])
def create_visit(
    visit: schema.VisitCreate, name: str, date: datetime, db: Session = Depends(get_db)
):
    return crud.create_visit(db=db, name=name, date=date, visit=visit)
