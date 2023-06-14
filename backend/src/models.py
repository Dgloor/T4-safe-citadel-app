from config.database import Base
from datetime import datetime
from uuid import uuid4
from sqlalchemy import Column, String, DateTime, ForeignKey, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import Enum


class VisitState(Enum):
    PENDING = "PENDING"
    REGISTERED = "REGISTERED"
    CANCELLED = "CANCELLED"
    EXPIRED = "EXPIRED"


class User(Base):
    __tablename__ = "user"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    name = Column(String, nullable=False)
    role = Column(String, nullable=False)
    created_date = Column(DateTime, default=datetime.now)
    updated_date = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    username = Column(String, nullable=False)


class Visit(Base):
    __tablename__ = "visit"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    created_date = Column(DateTime, default=datetime.now)
    date = Column(DateTime, nullable=False)
    state = Column(String, default=VisitState.PENDING)
    visitor_id = Column(UUID(as_uuid=True), ForeignKey("visitor.id"))
    guard_id = Column(UUID(as_uuid=True), ForeignKey("guard.id"))
    additional_info = Column(JSON, nullable=True)
    qr_id = Column(UUID(as_uuid=True), ForeignKey("qr.id"))
    resident_id = Column(UUID(as_uuid=True), ForeignKey("resident.id"))


class Visitor(Base):
    __tablename__ = "visitor"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    name = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.now)
    updated_at = Column(DateTime, default=datetime.now)


class FrequentVisitor(Base):
    __tablename__ = "frequent_visitor"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), ForeignKey("resident.id"), primary_key=True)
    visitor_id = Column(UUID(as_uuid=True), ForeignKey("visitor.id"))


class Guard(Base):
    __tablename__ = "guard"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("user.id"))


class Residence(Base):
    __tablename__ = "residence"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    address = Column(String, nullable=False)
    created_date = Column(DateTime, default=datetime.now)
    information = Column(JSON, nullable=True)


class Resident(User):
    __tablename__ = "resident"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), ForeignKey("user.id"), primary_key=True)
    phone = Column(String, nullable=False)
    residence_id = Column(UUID(as_uuid=True), ForeignKey("residence.id"))
    user_id = Column(UUID(as_uuid=True), ForeignKey("user.id"))
    residence = relationship("Residence", foreign_keys=[residence_id])
    user = relationship("User", foreign_keys=[user_id])
    __mapper_args__ = {
        "inherit_condition": id == User.id  # Ajusta la condición de herencia aquí
    }


class Qr(Base):
    __tablename__ = "qr"
    __table_args__ = {"extend_existing": True}
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    created_date = Column(DateTime, default=datetime.now)
    code = Column(String, default=str(uuid4()))
