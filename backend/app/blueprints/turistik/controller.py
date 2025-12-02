from sqlalchemy.sql import text
from app.blueprints.turistik.service import add_service,delete_service,update_service, get_service
from app.utils.utils import get_method_parser
from app.policies.policies import id_control_policy


def add_turistik_tesis_controller(data):
    
    statement1 = text(f"""INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
                    VALUES (:ulke,:sehir,:ilce,:mahalle,:cadde,:sokak,:bina_no,:daire_no,:posta_kodu,:olusturulma_tarihi,:guncellenme_tarihi );""")

    statement2 = text(f"""INSERT INTO kategori(kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES (:kategori_ismi, :olusturulma_tarihi, :guncellenme_tarihi); """)
    
    statement3 = text(f""" INSERT INTO Ilan (kullanici_id,adres_id,baslik,aciklama ,fiyat,kategori_id,ilan_tipi,kredi_uygunlugu ,kimden ,takas,
					olusturulma_tarihi ,guncellenme_tarihi) VALUES 
                    (:kullanici_id,:adres_id, :baslik, :aciklama , :fiyat, :kategori_id, :ilan_tipi, :kredi_uygunlugu , :kimden , :takas,
					:olusturulma_tarihi ,:guncellenme_tarihi);""")

    statement4= text(f""" INSERT INTO Emlak_Ilan (ilan_id,emlak_tipi,m2_brut,m2_net,tapu_durumu,olusturulma_tarihi ,guncellenme_tarihi)
                            VALUES (:ilan_id,:emlak_tipi,:m2_brut,:m2_net,:tapu_durumu,:olusturulma_tarihi ,:guncellenme_tarihi) ; """)

    statement5 = text(f""" INSERT INTO Yerleske_Ilan (emlak_id,yerleske_tipi,oda_sayisi,bina_yasi,bulundugu_kat,kat_sayisi,
							isitma,otopark,olusturulma_tarihi,guncellenme_tarihi)
                            VALUES (:emlak_id,:yerleske_tipi,:oda_sayisi,:bina_yasi,:bulundugu_kat,:kat_sayisi,
							:isitma,:otopark,:olusturulma_tarihi,:guncellenme_tarihi); """)

    statement6 = text(f""" INSERT INTO turistik_tesis(yerleske_id,apart_sayisi,yatak_sayisi,acik_alan_m2,kapali_alan_m2,zemin_etudu,
							yapi_durumu,olusturulma_tarihi,guncellenme_tarihi)
                    VALUES (:yerleske_id,:apart_sayisi,:yatak_sayisi,:acik_alan_m2,:kapali_alan_m2,:zemin_etudu,
							:yapi_durumu,:olusturulma_tarihi,:guncellenme_tarihi); """)

    statement_list = [statement1,statement2,statement3,statement4,statement5,statement6]

    # try-catch ortak olmalı try-catch one data handler
    response  = add_service(data,statement_list)

    return response


def delete_turistik_tesis_controller(data):

    if not (id_control_policy("turistik_tesis", "turistik_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    statement = text(f""" DELETE ilan,kategori,adres
                        FROM turistik_tesis 
                        INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = turistik_tesis.yerleske_id
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        WHERE turistik_tesis.turistik_id = :turistik_id;  """)

    response = delete_service(data,statement)

    return response



def update_turistik_tesis_controller(data):

    if not (id_control_policy("turistik_tesis", "turistik_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement = text(f""" UPDATE turistik_tesis
                        INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = turistik_tesis.yerleske_id
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        SET {object_set_sql}
                        WHERE turistik_tesis.turistik_id = :turistik_id ; """)

    response = update_service(data,statement)

    return response


def get_turistik_tesis_controller(data):
    
    
    query_str,data = get_method_parser(data)
    print(query_str)
    print(data)
    
    
    statement = text(f""" SELECT * FROM turistik_tesis 
                        INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = turistik_tesis.yerleske_id
                        INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
                        INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        {query_str}
                        """)
    
    statement2 = text(f""" SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
		'turistik_tesis', 
        'yerleske_ilan', 
        'emlak_ilan', 
        'ilan', 
        'adres', 
        'kategori' 
) ORDER BY FIELD(TABLE_NAME, 
        'turistik_tesis', 
        'yerleske_ilan', 
        'emlak_ilan', 
        'ilan', 
        'adres', 
        'kategori'
    ),
    ORDINAL_POSITION; """)

    statement_list= [statement,statement2]
    response = get_service(data,statement_list)

    return response