import sqlalchemy.exc
from app.utils.utils import engine 
import sqlalchemy

def add_service(data,statement):
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data integration hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Adres başarıyla oluşturuldu",200   


def delete_service(data,statement):
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data integration hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Adres başarıyla silindi",200   



def update_service(data,statement):
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data integration hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Adres başarıyla güncellendi",200 



def get_service(data,statement):
    
    with engine.connect() as con:
        try: 
            for row in con.execute(statement,data):
                result = row

            result = {"adres_id": result[0],"ulke": result[1], "sehir": result[2], "ilce": result[3], "mahalle": result[4],
                       "cadde": result[5], 
                      "sokak": result[6],"bina_no": result[7],"daire_no": result[8],"posta_kodu":result[9] ,
                      "olusturulma_tarihi": result[10],"guncellenme_tarihi": result[11]}

            print(result)    
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data entegrasyon hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var (adres_id) lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return result, 200 