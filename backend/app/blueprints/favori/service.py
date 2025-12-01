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
            return  "Veri entegrasyonu hatası !",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Favori başarıyla oluşturuldu",200   

def delete_service(data,statement):
    
    with engine.connect() as con:

        try: 
            con.execute(statement, data)
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Veri entegrasyonu hatası !",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "Favori başarıyla kaldırıldı",200  


def get_service(data,statement):
    
    with engine.connect() as con:

        try: 
            for row in con.execute(statement,data):
                result = row

            result = {"kullanici_id": result[1],"ilan_id": result[0], "olusturulma_tarihi": result[2]}    
            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Veri entegrasyonu hatası !",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return result,200  
    