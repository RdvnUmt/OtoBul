from app.blueprints.favori.service import add_service,delete_service,get_service
from sqlalchemy.sql import text



def add_favori_controller(data):
    
    statement = text(f"""INSERT INTO Favori (ilan_id,kullanici_id, olusturulma_tarihi) 
                            VALUES (:ilan_id, :kullanici_id ,:olusturulma_tarihi );""")

    response  = add_service(data,statement)

    return response


def delete_favori_controller(data):
 
    statement = text(f"""DELETE FROM favori WHERE favori.ilan_id = :ilan_id AND favori.kullanici_id = :kullanici_id;""")

    response  = delete_service(data,statement)

    return response


def get_favori_controller(data):
    
    statement = text(f"""SELECT * FROM favori WHERE favori.kullanici_id = :kullanici_id;""")
    response  = get_service(data,statement)

    return response