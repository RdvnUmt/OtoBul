from sqlalchemy.sql import text
from app.blueprints.motosiklet.service import add_service,delete_service,update_service, get_service
from app.utils.utils import get_method_parser
from app.policies.policies import id_control_policy

def add_motosiklet_controller(data):
    
    statement1 = text(f"""INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
                    VALUES (:ulke,:sehir,:ilce,:mahalle,:cadde,:sokak,:bina_no,:daire_no,:posta_kodu,:olusturulma_tarihi,:guncellenme_tarihi );""")

    statement2 = text(f"""INSERT INTO kategori(kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES (:kategori_ismi, :olusturulma_tarihi, :guncellenme_tarihi); """)
    
    statement3 = text(f""" INSERT INTO Ilan (kullanici_id,adres_id,baslik,aciklama ,fiyat,kategori_id,ilan_tipi,kredi_uygunlugu ,kimden ,takas,
					olusturulma_tarihi ,guncellenme_tarihi) VALUES 
                    (:kullanici_id,:adres_id, :baslik, :aciklama , :fiyat, :kategori_id, :ilan_tipi, :kredi_uygunlugu , :kimden , :takas,
					:olusturulma_tarihi ,:guncellenme_tarihi);""")

    statement4 = text(f""" INSERT INTO marka(marka_name,olusturulma_tarihi) VALUES (:marka_name,:olusturulma_tarihi); """)

    statement5 = text(f""" INSERT INTO seri(marka_id, seri_ismi,olusturulma_tarihi) VALUES (:marka_id, :seri_ismi,:olusturulma_tarihi); """)

    statement6 = text(f""" INSERT INTO model(seri_id, model_yili, mensei, model_ismi, olusturulma_tarihi)
			VALUES (:seri_id, :model_yili, :mensei, :model_ismi, :olusturulma_tarihi); """)

    statement7 = text(f""" INSERT INTO Vasita_Ilan (ilan_id,vasita_tipi,model_id ,yakit_tipi ,vites,arac_durumu ,km ,motor_gucu ,motor_hacmi,renk,garanti, 
							agir_hasar_kaydi,plaka_uyruk,olusturulma_tarihi,guncellenme_tarihi) VALUES
                        (:ilan_id,:vasita_tipi,:model_id ,:yakit_tipi ,:vites,:arac_durumu ,:km ,:motor_gucu ,:motor_hacmi,:renk,:garanti, 
							:agir_hasar_kaydi,:plaka_uyruk,:olusturulma_tarihi,:guncellenme_tarihi);  """)

    statement8 = text(f""" INSERT INTO motosiklet(vasita_id,zamanlama_tipi,silindir_sayisi,sogutma,olusturulma_tarihi,guncellenme_tarihi) 
                    VALUES (:vasita_id,:zamanlama_tipi,:silindir_sayisi,:sogutma,:olusturulma_tarihi,:guncellenme_tarihi); """)

    statement_list = [statement1,statement2,statement3,statement4,statement5,statement6,statement7,statement8]

    # try-catch ortak olmalı try-catch one data handler
    response  = add_service(data,statement_list)

    return response


def delete_motosiklet_controller(data):

    if not (id_control_policy("motosiklet", "moto_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    statement = text(f""" DELETE ilan,kategori,adres, marka
                        FROM motosiklet 
                        INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = motosiklet.vasita_id
                        INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        INNER JOIN model ON vasita_ilan.model_id = model.model_id
                        INNER JOIN seri ON model.seri_id = seri.seri_id
                        INNER JOIN marka ON marka.marka_id = seri.marka_id
                        WHERE motosiklet.moto_id = :moto_id;  """)

    response = delete_service(data,statement)

    return response



def update_motosiklet_controller(data):
    
    if not (id_control_policy("motosiklet", "moto_id", data)):
        return "Bunu yapmaya yetkiniz yok!",401

    resultstr = ""
    for item in(data.keys()):
        resultstr =  resultstr  + f"{item} = :{item},"

    object_set_sql = resultstr[:len(resultstr)-1]

    statement = text(f""" UPDATE motosiklet
                        INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = motosiklet.vasita_id
                        INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        INNER JOIN model ON vasita_ilan.model_id = model.model_id
                        INNER JOIN seri ON model.seri_id = seri.seri_id
                        INNER JOIN marka ON marka.marka_id = seri.marka_id 
                        SET {object_set_sql}
                        WHERE motosiklet.moto_id = :moto_id; """)

    response = update_service(data,statement)

    return response


def get_motosiklet_controller(data):
    query_str,data = get_method_parser(data)
    print(query_str)
    print(data)
    
    statement = text(f""" SELECT * FROM motosiklet 
                        INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = motosiklet.vasita_id
                        INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
                        INNER JOIN adres ON ilan.adres_id = adres.adres_id
                        INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
                        INNER JOIN model ON vasita_ilan.model_id = model.model_id
                        INNER JOIN seri ON model.seri_id = seri.seri_id
                        INNER JOIN marka ON marka.marka_id = seri.marka_id
                        {query_str}  """)
    
    statement2 = text(f""" SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
		'motosiklet', 
        'vasita_ilan', 
        'ilan', 
        'adres', 
        'kategori', 
        'model', 
        'seri', 
        'marka'
) ORDER BY FIELD(TABLE_NAME, 
        'motosiklet', 
        'vasita_ilan', 
        'ilan', 
        'adres', 
        'kategori', 
        'model', 
        'seri', 
        'marka'
    ),
    ORDINAL_POSITION; """)

    statement_list= [statement,statement2]
    response = get_service(data,statement_list)

    return response