"""
This file is used to initialize the firebase database.
"""
import pyrebase


config = {
    "apiKey": "AIzaSyDxLIihYYuak_QCmLCE-WYgZEpV2JT5qCs",
    "authDomain": "backend-89a28.firebaseapp.com",
    "databaseURL": "https://backend-89a28-default-rtdb.firebaseio.com",
    "projectId": "backend-89a28",
    "storageBucket": "backend-89a28.appspot.com",
    "messagingSenderId": "932188325765",
    "appId": "1:932188325765:web:136a245924c242ad32e6ec",
    "measurementId": "G-2NZB188ZE3",
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

print(db)
