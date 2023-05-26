from pydantic import BaseModel


class User(BaseModel):
    username: str
    password: str
    email: str
    full_name: str = None
    disabled: bool = None
