from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class Kullanici(Base):
    __tablename__ = 'kullanici'
    kullanici_id = Column(Integer, primary_key=True,autoincrement=True)
    email = Column(String, primary_key=True, default="mailimbenim")
    sifre = Column(String, default="123456")
    adres_id = Column(Integer)
    ad = Column(String, nullable=False) 
    soyad = Column(String, nullable=False)
    telefon_no = Column(String, nullable=False)
    kullanici_tipi = Column(String, nullable=False)
    olusturulma_tarihi = Column(DateTime, nullable=False)
    guncellenme_tarihi = Column(DateTime, nullable=False)
    def is_active(self):
        return True
    def get_id(self):
        return self.id
    