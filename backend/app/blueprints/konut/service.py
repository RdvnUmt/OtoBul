

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

             # emlak ilan oluştur
            con.execute(statement_list[3],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                emlak_id = row
            print(emlak_id)
            data['emlak_id'] = emlak_id[0]

            #yerleşke ilan oluştur
            con.execute(statement_list[4],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                yerleske_id = row
            print(yerleske_id)
            data['yerleske_id'] = yerleske_id[0]


            #konut_ilan İlan 
            con.execute(statement_list[5],data)
            smt = text(f"""SELECT last_insert_id() AS id""")
            for row in con.execute(smt):
                konut_ilan_id = row
            print(konut_ilan_id)
            data['konut_id'] = konut_ilan_id[0]

            con.commit()
        except sqlalchemy.exc.DataError as e:
            return f"Verilerinizi lütfen kontrol edin!",400
        except sqlalchemy.exc.IntegrityError  as e:
            return  "Lütfen farklı veri giriniz!",400
        except sqlalchemy.exc.InvalidRequestError as e:
            return "Gönderilen verilede eksiklik var lütfen ekleyiniz!",400
        except Exception as e :
            return f"Bilinmeyen Hata: {e}",520
        
    return "konut_ilan başarıyla oluşturuldu",200    




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
        
    return "konut_ilan başarıyla silindi",200   



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
        
    return "konut_ilan başarıyla güncellendi",200   


def get_service(data,statement_list):
    result2 = []
    result = []
    with engine.connect() as con:
        try: 
            for row in con.execute(statement_list[0],data):
                result.append(row)
           

            for row in con.execute(statement_list[1],data):
                result2.append(row[0])
      

            resultobj= []
            result_iter = {}
            for j in range (len(result)):
                result_iter = {}
                for i in range(len(result2)):
                    result_iter[f'{result2[i]}'] = result[j][i] 
                resultobj.append(result_iter)
                
       

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