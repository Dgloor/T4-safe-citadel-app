import models
import config.database as database
import logging


def create_qr():
    qr = models.Qr()
    try:
        logging.info("Creating Qr")
        database.db.child("qr").push(qr.dict())
        return qr
    except Exception as e:
        logging.error("Error creating Qr", e)
        Exception("Error creating Qr")
