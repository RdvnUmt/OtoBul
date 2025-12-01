import sqlalchemy.exc
from app.utils.utils import engine 
import sqlalchemy


# Ortak bir execute servisimiz olacak ve gereken error handling burada yapılacak!

def add_service(data,statement):
    
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Lütfen farklı bir email giriniz!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Kullanıcı başarıyla oluşturuldu",200    


def delete_service(data,statement):
    
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data entegrasyon hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Kullanıcı başarıyla silindi",200    


def update_service(data,statement):
    
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data entegrasyon hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var (kullanıcı_id) lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Kullanıcı başarıyla güncellendi",200   



def get_service(data,statement):
    
    with engine.connect() as con:
        try: 
            for row in con.execute(statement,data):
                result = row

            result = {"kullanici_id": result[0],"adres_id": result[1], "email": result[2], "sifre": result[3], "ad": result[4],
                       "soyad": result[5], 
                      "telefon_no": result[6],"kullanici_tipi": result[7], "olusturulma_tarihi": result[8],
                      "guncellenme_tarihi": result[9]}

            print(result)    
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data entegrasyon hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var (kullanıcı_id) lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return result, 200 