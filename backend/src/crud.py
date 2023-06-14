from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Type
from config.database import Base
from src import models, schema
from datetime import datetime
import uuid


def create_model(db: Session, model_schema: Type[BaseModel], model: Type[Base]):
    db_model = model(**model_schema.dict())
    db.add(db_model)
    db.commit()
    db.refresh(db_model)
    return db_model


# CREATE
def create_visitor(db: Session, name: str):
    while True:
        new_id = uuid.uuid4()
        existing_visitor = db.query(models.Visitor).filter_by(id=new_id).first()
        if existing_visitor is None:
            visitor = models.Visitor(id=new_id, name=name)
            db.add(visitor)
            db.commit()
            return visitor


def create_visit(db: Session, name: str, date: datetime, visit: schema.VisitCreate):
    visit.qr_id = create_qr(db).id
    visit.visitor_id = create_visitor(db, name).id
    visit.date = date
    return create_model(db, visit, models.Visit)


def create_frequent_visitor(
    db: Session, frequent_visitor: schema.FrequentVisitorCreate
):
    return create_model(db, frequent_visitor, models.FrequentVisitor)


def create_guard(db: Session, guard: schema.GuardCreate):
    return create_model(db, guard, models.Guard)


def create_user(db: Session, user: schema.UserCreate):
    return create_model(db, user, models.User)


def create_resident(db: Session, resident: schema.ResidentCreate):
    return create_model(db, resident, models.Resident)


def create_residence(db: Session, residence: schema.ResidenceCreate):
    return create_model(db, residence, models.Residence)


def create_qr(db: Session):
    while True:
        new_id = uuid.uuid4()
        existing_qr = db.query(models.Qr).filter_by(id=new_id).first()
        if existing_qr is None:
            qr = models.Qr(id=new_id)
            db.add(qr)
            db.commit()
            return qr


# READ
def get_visitor(db: Session, visitor_id: str):
    return db.query(models.Visitor).filter(models.Visitor.id == visitor_id).first()


def get_visit(db: Session, visit_id: str):
    return db.query(models.Visit).filter(models.Visit.id == visit_id).first()


def get_frequent_visitor(db: Session, frequent_visitor_id: str):
    return (
        db.query(models.FrequentVisitor)
        .filter(models.FrequentVisitor.id == frequent_visitor_id)
        .first()
    )


def get_guard(db: Session, guard_id: str):
    return db.query(models.Guard).filter(models.Guard.id == guard_id).first()


def get_user(db: Session, user_id: str):
    return db.query(models.User).filter(models.User.id == user_id).first()


def get_resident(db: Session, resident_id: str):
    return db.query(models.Resident).filter(models.Resident.id == resident_id).first()


def get_residence(db: Session, residence_id: str):
    return (
        db.query(models.Residence).filter(models.Residence.id == residence_id).first()
    )


def get_qr(db: Session, qr_id: str):
    return db.query(models.QR).filter(models.QR.id == qr_id).first()


# DELETEL


def delete_visitor(db: Session, visitor_id: str):
    db.query(models.Visitor).filter(models.Visitor.id == visitor_id).delete()
    db.commit()


def delete_visit(db: Session, visit_id: str):
    db.query(models.Visit).filter(models.Visit.id == visit_id).delete()
    db.commit()


def delete_frequent_visitor(db: Session, frequent_visitor_id: str):
    db.query(models.FrequentVisitor).filter(
        models.FrequentVisitor.id == frequent_visitor_id
    ).delete()
    db.commit()


def delete_guard(db: Session, guard_id: str):
    db.query(models.Guard).filter(models.Guard.id == guard_id).delete()
    db.commit()


def delete_user(db: Session, user_id: str):
    db.query(models.User).filter(models.User.id == user_id).delete()
    db.commit()


def delete_resident(db: Session, resident_id: str):
    db.query(models.Resident).filter(models.Resident.id == resident_id).delete()
    db.commit()


def delete_residence(db: Session, residence_id: str):
    db.query(models.Residence).filter(models.Residence.id == residence_id).delete()
    db.commit()
