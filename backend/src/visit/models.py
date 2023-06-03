from pydantic import BaseModel
from typing import Union
from enum import Enum
import models
import datetime
import qr.models as qr_models


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
    qr: Union[qr_models.Qr, None] = None
    additional_info: Union[dict, None] = None
