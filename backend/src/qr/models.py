import datetime
from pydantic import BaseModel
import uuid
import time
import hashlib


class Qr(BaseModel):
    date: datetime.time = datetime.datetime.now()
    uuid: uuid.UUID = uuid.uuid4()


