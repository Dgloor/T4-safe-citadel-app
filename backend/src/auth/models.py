"""
Models for the auth service.
"""

from pydantic import BaseModel


class User(BaseModel):
    """
    This class is used to represent a user."""

    username: str
    password: str
    email: str
    full_name: str = None
    disabled: bool = None
