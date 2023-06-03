from sqlalchemy import Column, String, DateTime, ForeignKey, Enum, JSON
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.sql import text
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime
from uuid import uuid4

Base = declarative_base()


class VisitState(str, Enum):
    PENDING = "PENDING"
    REGISTERED = "REGISTERED"
    CANCELLED = "CANCELLED"
    EXPIRED = "EXPIRED"


class User(Base):
    __tablename__ = "user"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    name = Column(String, nullable=False)
    role = Column(String, nullable=False)
    created_date = Column(DateTime, default=datetime.now)
    updated_date = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    username = Column(String, nullable=False)


class Guard(User):
    __tablename__ = "guard"
    id = Column(UUID(as_uuid=True), ForeignKey("user.id"), primary_key=True)


class Resident(User):
    __tablename__ = "resident"
    id = Column(UUID(as_uuid=True), ForeignKey("user.id"), primary_key=True)
    phone = Column(String, nullable=False)
    residence_id = Column(UUID(as_uuid=True), ForeignKey("residence.id"))
    residence = relationship("Residence", back_populates="resident")


class FrequentVisitor(Base):
    __tablename__ = "frequent_visitor"
    id = Column(UUID(as_uuid=True), ForeignKey("resident.id"), primary_key=True)
    visitor_id = Column(UUID(as_uuid=True), ForeignKey("visitor.id"))


class Residence(Base):
    __tablename__ = "residence"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    address = Column(String, nullable=False)
    created_date = Column(DateTime, default=datetime.now)
    information = Column(JSON, nullable=True)
    resident_id = Column(UUID(as_uuid=True), ForeignKey("resident.id"))
    resident = relationship("Resident", back_populates="residence")


class Visitor(Base):
    __tablename__ = "visitor"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    created_date = Column(DateTime, default=datetime.now)
    updated_date = Column(DateTime, default=datetime.now, onupdate=datetime.now)


class Qr(Base):
    __tablename__ = "qr"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    created_date = Column(DateTime, default=datetime.now)
    code = Column(String, default=str(uuid4()))


class Visit(Base):
    __tablename__ = "visit"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid4)
    created_date = Column(DateTime, default=datetime.now)
    date = Column(DateTime, nullable=False)
    state = Column(String, default=VisitState.PENDING)
    visitor_id = Column(UUID(as_uuid=True), ForeignKey("visitor.id"))
    guard_id = Column(UUID(as_uuid=True), ForeignKey("guard.id"))
    additional_info = Column(JSON, nullable=True)
    qr_id = Column(UUID(as_uuid=True), ForeignKey("qr.id"))
