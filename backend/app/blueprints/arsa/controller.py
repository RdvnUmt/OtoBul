from sqlalchemy.sql import text
from app.blueprints.arsa.service import add_service,delete_service,update_service, get_service
from app.utils.utils import get_method_parser
from app.policies.policies import id_control_policy

def add_arsa_controller(data):
    
    statement1 = text(f"""INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
                    VALUES (:ulke,:sehir,:ilce,:mahalle,:cadde,:sokak,:bina_no,:daire_no,:posta_kodu,:olusturulma_tarihi,:guncellenme_tarihi );""")

    statement2 = text(f"""INSERT INTO kategori(kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES (:kategori_ismi, :olusturulma_tarihi, :guncellenme_tarihi); """)
    
    statement3 = text(f""" INSERT INTO Ilan (kullanici_id,adres_id,baslik,aciklama ,fiyat,kategori_id,ilan_tipi,kredi_uygunlugu ,kimden ,takas,
					olusturulma_tarihi ,guncellenme_tarihi) VALUES 
                    (:kullanici_id,:adres_id, :baslik, :aciklama , :fiyat, :kategori_id, :ilan_tipi, :kredi_uygunlugu , :kimden , :takas,
					:olusturulma_tarihi ,:guncellenme_tarihi);""")

    statement4= text(f""" INSERT INTO Emlak_Ilan (ilan_id,emlak_tipi,m2_brut,m2_net,tapu_durumu,olusturulma_tarihi ,guncellenme_tarihi)
                            VALUES (:ilan_id,:emlak_tipi,:m2_brut,:m2_net,:tapu_durumu,:olusturulma_tarihi ,:guncellenme_tarihi) ; """)


    statement5 = text(f""" INSERT INTO arsa(emlak_id,imar_durumu,ada_no ,parsel_no ,pafta_no ,kaks_emsal ,gabari,olusturulma_tarihi ,guncellenme_tarihi )
                    VALUES (:emlak_id,:imar_durumu,:ada_no ,:parsel_no ,:pafta_no ,:kaks_emsal ,:gabari,:olusturulma_tarihi ,:guncellenme_tarihi ) """)

    statement_list = [statement1,statement2,statement3,statement4,statement5]

    # try-catch ortak olmalı try-catch one data handler: 
    response  = add_service(data,statement_list)

    return response


def delete_arsa_controller(data):

    if not (id_control_policy("arsa", "arsa_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    statement = text(f""" DELETE ilan,kategori,adres
                        FROM arsa 
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        WHERE arsa.arsa_id = :arsa_id;   """)

    response = delete_service(data,statement)

    return response



def update_arsa_controller(data):

    if not (id_control_policy("arsa", "arsa_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement = text(f""" UPDATE arsa
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        SET  {object_set_sql}
                        WHERE arsa.arsa_id = :arsa_id ; """)

    response = update_service(data,statement)

    return response


def get_arsa_controller(data):

    query_str,data = get_method_parser(data)
    print(query_str)
    print(data)

    statement = text(f""" SELECT * FROM arsa 
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        {query_str} 
                        """)
    
    statement2 = text(f""" SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
		'arsa', 
        'emlak_ilan', 
        'ilan', 
        'adres', 
        'kategori' 
) ORDER BY FIELD(TABLE_NAME, 
        'arsa', 
        'emlak_ilan', 
        'ilan', 
        'adres', 
        'kategori'
    ),
    ORDINAL_POSITION; """)

    statement_list= [statement,statement2]
    response = get_service(data,statement_list)

    return response