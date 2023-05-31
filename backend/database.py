"""
This file is used to initialize the firebase database.
"""
import json
import firebase_admin
from firebase_admin import credentials
import pyrebase


def initialize_firebase():
    """
    This function is used to initialize the firebase database.
    :return: database instance
    """
    cred = credentials.Certificate("src/auth/firebase.json")
    firebase_admin.initialize_app(cred)
    pb = pyrebase.initialize_app(json.load(open("src/auth/firebase.json")))
    db = pb.database()
    return db


database_instance = initialize_firebase()
