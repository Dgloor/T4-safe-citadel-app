from pydantic import BaseModel
from typing import List, Union
import datetime
import uuid


class Person(BaseModel):
    name: str
    last_name: str


class User(Person):
    username: str
    password: str
    created_at: datetime = datetime.now()
    updated_at: datetime


class Visitor(Person):
    resident_id: Union[uuid.UUID, None] = None
    created_at: datetime = datetime.now()
    updated_at: datetime

    def to_dict(self):
        return self.dict()


class Residence(BaseModel):
    name: str
    address: str
    created_at: datetime = datetime.now()
    information: Union[dict, None] = None

    def to_dict(self):
        return self.dict()


class Resident(User):
    uuid: uuid.UUID = uuid.uuid4()
    phone: str
    frecuent_visitors: List[Visitor] = []

    def add_frecuent_visitor(self, visitor: Visitor):
        pass

    def to_dict(self):
        return self.dict()


class Guard(User):
    pass

    def to_dict(self):
        return self.dict()

    def register_visit(self, visit):
        pass

    def request_visit(self, visit):
        pass

    def get_visits(self):
        pass

    def approve_visit(self, visit):
        pass


class Administrator(User):
    pass
