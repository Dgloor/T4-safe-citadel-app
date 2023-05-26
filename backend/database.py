import firebase_admin
import pyrebase
import json
from firebase_admin import credentials, auth

cred = credentials.Certificate("src/auth/firebase.json")
firebase_admin.initialize_app(cred)
pb = pyrebase.initialize_app(json.load(open("src/auth/firebase.json")))
db = pb.database()
