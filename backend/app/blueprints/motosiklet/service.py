

import sqlalchemy.exc
from app.utils.utils import engine 
import sqlalchemy
from sqlalchemy.sql import text




def add_service(data,statement_list):
    
    with engine.connect() as con:

        try: 
            
            # address oluştur
            con.execute(statement_list[0], data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                adres_id = row
            print(adres_id)
            data['adres_id'] = adres_id[0]

            # kategori oluştur
            con.execute(statement_list[1],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                kategori_id = row
            print(kategori_id)
            data['kategori_id'] = kategori_id[0]

            #ilan oluştur
            con.execute(statement_list[2],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                ilan_id = row
            print(ilan_id)
            data['ilan_id'] = ilan_id[0]

            #marka oluştur
            con.execute(statement_list[3],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                marka_id = row
            print(marka_id)
            data['marka_id'] = marka_id[0]

            #seri oluştur
            con.execute(statement_list[4],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                seri_id = row
            print(seri_id)
            data['seri_id'] = seri_id[0]

            #model
            con.execute(statement_list[5],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                model_id = row
            print(model_id)
            data['model_id'] = model_id[0]

            #Vasıta İlan 
            con.execute(statement_list[6],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                vasita_id = row
            print(vasita_id)
            data['vasita_id'] = vasita_id[0]

            #motosiklet İlan 
            con.execute(statement_list[7],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                motosiklet_id = row
            print(motosiklet_id)
            data['moto_id'] = motosiklet_id[0]

            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Lütfen farklı veri giriniz!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"Bilinmeyen Hata: {e}",520
        
    return "motosiklet başarıyla oluşturuldu",200    




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
        
    return "motosiklet başarıyla silindi",200   



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
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"{e}",520
        
    return "motosiklet başarıyla güncellendi",200   


def get_service(data,statement_list):
    result2 = []
    result = []
    with engine.connect() as con:
        try: 
            for row in con.execute(statement_list[0],data):
                result.append(row)
            print(f"RESULT  : {result}")   
            print(f"RESULT LEN : {len(result)}")  

            for row in con.execute(statement_list[1],data):
                result2.append(row[0])
            print(f"RESULT2  : {result2}")  

            resultobj= []
            result_iter = {}
            for j in range (len(result)):
                result_iter = {}
                for i in range(len(result2)):
                    result_iter[f'{result2[i]}'] = result[j][i] 
                resultobj.append(result_iter)
                
            print(f"RESULTOBJ  :{resultobj}")

            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Data entegrasyon hatası!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var (kullanıcı_id) lütfen ekleyiniz!",400
        except Exception as e :
            print(e)
            return f"{e}",520
        
    return resultobj, 200 