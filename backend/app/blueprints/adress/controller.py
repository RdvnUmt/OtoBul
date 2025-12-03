from sqlalchemy.sql import text
from app.blueprints.adress.service import add_service, delete_service, update_service,get_service
from app.utils.utils import dynamic_insert_parser



def add_address_controller(data):


    sql, data =  dynamic_insert_parser(data)
    print(sql)
    print(data)

    statement = text(f"""INSERT INTO adres {sql}""")

    # (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
    #                VALUES (:ulke,:sehir,:ilce,:mahalle,:cadde,:sokak,:bina_no,:daire_no,:posta_kodu,:olusturulma_tarihi,:guncellenme_tarihi );
    


    response  = add_service(data,statement)

    return response


def delete_address_controller(data):
    statement = text(f"""DELETE FROM adres WHERE adres_id= :adres_id;""")
    response  = delete_service(data,statement)

    return response


def update_address_controller(data):
    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement = text(f"""UPDATE adres SET {object_set_sql} WHERE adres_id=:adres_id ;""")
    response  = update_service(data,statement)

    return response


def get_address_controller(data):

    
    statement = text(f"""SELECT * FROM adres WHERE adres_id = :adres_id""")
    response  = get_service(data,statement)

    return response

