from flask_sqlalchemy import SQLAlchemy
import datetime
from sqlalchemy.orm import mapped_column,Mapped,DeclarativeBase

class Base(DeclarativeBase):
    pass

class User(Base):
    __tablename__ = "user"
    userid: Mapped[int]  = mapped_column(primary_key=True)
    email: Mapped[str] = mapped_column(unique = True)
    password: Mapped[str]



    # first_name: db.Column(db.String(25),nullable=False)
    # last_name: db.Column(db.String(25),nullable=False)
    # phone_number: db.Column(db.String(15),nullable=False)
    # user_type: db.Column(db.String(20),nullable=False)
    # created_at: db.Column(db.DateTime, default= datetime.datetime.now)
    # updated_at: db.Column(db.DateTime, default= datetime.datetime.now)