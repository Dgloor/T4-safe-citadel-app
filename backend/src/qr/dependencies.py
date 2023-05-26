import models
import database
import logging


def create_qr():
    qr = models.Qr()
    try:
        logging.info("Creating Qr")
        database.db.child("qr").push(qr.dict())
        return qr
    except:
        logging.error("Error creating Qr")
        Exception("Error creating Qr")


