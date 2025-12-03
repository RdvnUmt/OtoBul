-- CRUD for Arsa

use Bil372Proje;

START TRANSACTION;
-- CREATE Arsa
-- Adres, Kategori, İlan, Emlak_İlan, Arsa

INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
VALUES ("Türkiye","Ankara","Çankaya","Beştepe", "Söğütözü","22",12,"612","06560",NOW(), NOW());

SET @address_id = last_insert_id();

INSERT INTO kategori(kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES ("Otomobil", NOW(), NOW());

INSERT INTO Ilan (kullanici_id,adres_id,baslik,aciklama ,fiyat,kategori_id,ilan_tipi,kredi_uygunlugu ,kimden ,takas,
					olusturulma_tarihi ,guncellenme_tarihi) VALUES 
(1,@address_id,"Araç satılık", "Aracımız 144Hpdir temizdir sadedir!", 1450000, last_insert_id(), 2, 0, 1, 1, NOW(), NOW());

SET @id_ilan = last_insert_id();

-- Emlak İlan
INSERT INTO Emlak_Ilan (ilan_id,emlak_tipi,m2_brut,m2_net,tapu_durumu,olusturulma_tarihi ,guncellenme_tarihi)
VALUES (@id_ilan, "Daire", 100, 90, "tapulu", NOW(), NOW());

-- Arsa İlan
INSERT INTO Arsa (emlak_id,imar_durumu,ada_no ,parsel_no ,pafta_no ,kaks_emsal ,gabari,olusturulma_tarihi ,guncellenme_tarihi )
VALUES(last_insert_id() , "İmara Açık", 455, 2321, 1231,"Emsal50", "Gabar20", NOW(), NOW());
                        
COMMIT;


-- Arsa SELECT
SELECT * FROM arsa 
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id; 


-- UPDATE Arsa
UPDATE arsa
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
SET kategori_ismi = "Kategori nedir lo", imar_durumu  = "Kapalıyız Kardeşim"
WHERE arsa.arsa_id = 1;


-- DELETE Arsa
-- Silme işlemi için ilan kategori adresin silinmesi yeterli
DELETE ilan,kategori,adres
FROM arsa 
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = arsa.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
WHERE arsa.arsa_id = 1; 
