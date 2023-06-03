import datetime
from pydantic import BaseModel
import uuid


class Qr(BaseModel):
    created_date: datetime.time = datetime.datetime.now()
    uid: uuid.UUID = uuid.uuid4()
