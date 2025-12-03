from sqlalchemy.sql import text
from app.blueprints.user.service import add_service, delete_service, update_service,get_service
from app.utils.utils import dynamic_insert_parser
import bcrypt

def add_user_controller(data):
    
    sql, data =  dynamic_insert_parser(data)

    print(sql)
    print(data)

    statement = text(f"""INSERT INTO Kullanici {sql} """)

    # (adres_id ,email,sifre,ad,soyad,telefon_no,kullanici_tipi,olusturulma_tarihi,guncellenme_tarihi) VALUES 
    #                         (:adres_id ,:email,:sifre,:ad,:soyad,:telefon_no,:kullanici_tipi,:olusturulma_tarihi,:guncellenme_tarihi);

    # try-catch ortak olmalı try-catch one data handler
    response  = add_service(data,statement)

    return response

def delete_user_controller(data):

    # data => kullanici_id = (int değer)

    statement = text(f"""DELETE  FROM Kullanici WHERE kullanici.kullanici_id = :kullanici_id; """)
    response = delete_service(data,statement)

    return response

def update_user_controller(data):
    # değiştirilecekler listesi + kullanici_id

    if 'sifre' in data and data['sifre']:
        plain_pw = data['sifre']
        if isinstance(plain_pw, str):
            hashed = bcrypt.hashpw(plain_pw.encode('utf-8'), bcrypt.gensalt())
            data['sifre'] = hashed.decode('utf-8')

    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement  =text(f"""UPDATE Kullanici SET {object_set_sql}  WHERE kullanici.kullanici_id = :kullanici_id;""")
    response = update_service(data,statement)

    return response


def get_user_controller(data):

    # İki farklı statement türü var 

    query_string = ""
    if data.get("email"):
        query_string = "WHERE kullanici.email =:email"
    elif data.get("kullanici_id"):    
        query_string = "WHERE kullanici.kullanici_id =:kullanici_id"

    print(query_string)     
    statement  =text(f"""SELECT * FROM Kullanici {query_string} ;""")
    response = get_service(data,statement)


    return response

