from sqlalchemy.sql import text
from app.blueprints.user.service import add_service, delete_service, update_service,get_service


def add_user_controller(data):
    
    statement = text(f"""INSERT INTO Kullanici (adres_id ,email,sifre,ad,soyad,telefon_no,kullanici_tipi,olusturulma_tarihi,guncellenme_tarihi) VALUES 
                            (:adres_id ,:email,:sifre,:ad,:soyad,:telefon_no,:kullanici_tipi,:olusturulma_tarihi,:guncellenme_tarihi);""")

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
    
    

    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement  =text(f"""UPDATE Kullanici SET {object_set_sql}  WHERE kullanici.kullanici_id = :kullanici_id;""")
    response = update_service(data,statement)

    return response


def get_user_controller(data):

    statement  =text(f"""SELECT * FROM Kullanici WHERE kullanici.email =:email ;""")
    response = get_service(data,statement)


    return response

