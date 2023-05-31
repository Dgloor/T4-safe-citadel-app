""" 
Dependencies for authentication
"""
import json
import firebase_admin
import models
import pyrebase
import logging

cred = firebase_admin.credentials.Certificate("src/auth/firebase.json")
firebase_admin.initialize_app(cred)
pb = pyrebase.initialize_app(json.load(open("src/auth/firebase.json")))


def create_user(user: models.User):
    try:
        logging.info("Creating User")
        user = firebase_admin.auth.create_user(
            email=user.email,
            email_verified=False,
            password=user.password,
            disabled=False,
        )
        return user
    except:
        logging.error("Error creating User")
        Exception("Error creating User")


def get_user(user: models.User):
    try:
        logging.info("Getting User")
        user = firebase_admin.auth.get_user_by_email_and_password(
            user.email, user.password
        )
        jwt = user["idToken"]
        return jwt
    except:
        logging.error("Error getting User")
        Exception("Error getting User")


def verify_id_token(token):
    try:
        logging.info("Verifying Token")
        decoded_token = firebase_admin.auth.verify_id_token(token)
        uid = decoded_token["uid"]
        return uid
    except:
        logging.error("Error verifying Token")
        Exception("Error verifying Token")
