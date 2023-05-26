from pydantic import BaseModel
from ..auth.models import User


class Visitor(BaseModel):
    name: str
    phone: str
    homeowners: User
    visit_date: str
    visit_time: str
    house: str
