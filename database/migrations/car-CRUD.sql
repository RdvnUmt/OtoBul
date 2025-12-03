
use Bil372Proje;

START TRANSACTION;
-- CREATE Otomobil
-- Adres, Kategori, İlan, Marka, Seri, Model, Vasıta İlan, Otomobil

INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
VALUES ("Türkiye","Ankara","Çankaya","Beştepe", "Söğütözü","22",12,"612","06560",NOW(), NOW());

SET @address_id = last_insert_id();

INSERT INTO kategori(kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES ("Otomobil", NOW(), NOW());

INSERT INTO Ilan (kullanici_id,adres_id,baslik,aciklama ,fiyat,kategori_id,ilan_tipi,kredi_uygunlugu ,kimden ,takas,
					olusturulma_tarihi ,guncellenme_tarihi) VALUES 
(2,@address_id,"Araç satılık", "Aracımız 144Hpdir temizdir sadedir!", 1450000, last_insert_id(), "Satılık", 0, "Sahibinden", 1, NOW(), NOW());

SET @id_ilan = last_insert_id();

INSERT INTO marka(marka_name,olusturulma_tarihi) VALUES ("Peugot",NOW());

INSERT INTO seri(marka_id, seri_ismi,olusturulma_tarihi) VALUES (last_insert_id(),"T3",NOW());

INSERT INTO model(seri_id, model_yili, mensei, model_ismi, olusturulma_tarihi)
			VALUES (last_insert_id(),2004,"Fransa","Transporter", NOW());

INSERT INTO Vasita_Ilan (ilan_id,vasita_tipi,model_id ,yakit_tipi ,vites,arac_durumu ,km ,motor_gucu ,motor_hacmi,renk,garanti, 
							agir_hasar_kaydi,plaka_uyruk,olusturulma_tarihi,guncellenme_tarihi) VALUES
(@id_ilan,"Araç",last_insert_id(),"Benzin", "R4", "İyi", 10500,100,2500,"kırmızı","3 yıl",1,"TR",NOW(),NOW());         
-- Vasıta ilan kaldırıldı ilan_id yi nasıl bulacaz düşün
-- İlan id / İlan id / ilan id

INSERT INTO Otomobil(vasita_id,kasa_tipi,cekis,olusturulma_tarihi ,guncellenme_tarihi) 
VALUES (last_insert_id() ,"Hackback","Önden Çekiş", NOW(), NOW());
-- Otomobil id yi sil AUTO INCREMENT, vasita_id yi yukarıdan al!)
COMMIT;  


-- CAR SELECT
SELECT * FROM otomobil 
INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = otomobil.vasita_id
INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
INNER JOIN model ON vasita_ilan.model_id = model.model_id
INNER JOIN seri ON model.seri_id = seri.seri_id
INNER JOIN marka ON marka.marka_id = seri.marka_id; 


-- UPDATE (otomobil,vasita_ilan,ilan,adres,kategori,model,seri,marka) SET ulke = 'Portekiz' WHERE
UPDATE otomobil
INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = otomobil.vasita_id
INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
INNER JOIN model ON vasita_ilan.model_id = model.model_id
INNER JOIN seri ON model.seri_id = seri.seri_id
INNER JOIN marka ON marka.marka_id = seri.marka_id 
SET marka_name = 'Deneme1', vasita_tipi = "ADam ol"
WHERE otomobil.otomobil_id = 4;

-- Otomobil id den başlayarak tüm idleri elde et ve ardından hepsini sil
-- Silme işlemi için ilan kategori adres ve markanın silinmesi yeterli
DELETE ilan,kategori,adres, marka
FROM otomobil 
INNER JOIN vasita_ilan ON vasita_ilan.vasita_id = otomobil.vasita_id
INNER JOIN ilan ON vasita_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
INNER JOIN model ON vasita_ilan.model_id = model.model_id
INNER JOIN seri ON model.seri_id = seri.seri_id
INNER JOIN marka ON marka.marka_id = seri.marka_id
WHERE otomobil.otomobil_id = 1; 


