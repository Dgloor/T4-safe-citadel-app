from pydantic import BaseModel
from typing import Union
from enum import Enum
import models
import datetime
import qr.dependencies as qr


class VisitState(Enum):
    PENDING = "PENDING"
    REGISTERED = "REGISTERED"
    CANCELLED = "CANCELLED"
    EXPIRED = "EXPIRED"


class Visit(BaseModel):
    resident: models.Resident
    visitor: models.Visitor
    guard: models.Guard
    created_date: datetime = datetime.datetime.now()
    updated_date: Union[datetime.datetime, None] = None
    visit_date: Union[datetime.datetime, None] = None
    state: Union[VisitState, None] = VisitState.PENDING
    qr: Union[qr.Qr, None] = None
    additional_info: Union[dict, None] = None

    def register(self):
        self.state = VisitState.REGISTERED
        self.updated_date = datetime.datetime.now()
        self.qr = qr.create_qr()
        return self

    def cancel(self):
        self.state = VisitState.CANCELLED
        self.updated_date = datetime.datetime.now()
        return self

    def expire(self):
        self.state = VisitState.EXPIRED
        self.updated_date = datetime.datetime.now()
        return self

    def to_dict(self):
        return self.dict()
