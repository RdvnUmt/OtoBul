from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class Kullanici(Base):
    __tablename__ = 'kullanici'
    id = Column(Integer, primary_key=True)
    email = Column(String, primary_key=True)
    sifre = Column(String)

    def is_active(self):
        return True
    def get_id(self):
        return self.id
    