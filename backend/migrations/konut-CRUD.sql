-- Konut CRUD

use Bil372Proje;

START TRANSACTION;
-- CREATE Konut
-- Adres, Kategori, İlan, Emlak_İlan, Yerleşke_İlan, Konut

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

-- Yerleşke İlan
INSERT INTO Yerleske_Ilan (emlak_id,yerleske_tipi,oda_sayisi,bina_yasi,bulundugu_kat,kat_sayisi,
							isitma,otopark,olusturulma_tarihi,guncellenme_tarihi)
VALUES (last_insert_id(),"Daire", 3 , 24, 5, 10, "Merkezi Isıtma", 1, NOW(), NOW());

-- Konut İlan
INSERT INTO Konut_Ilan (yerleske_id ,banyo_sayisi ,mutfak_tipi ,balkon ,asansor ,esyali ,kullanim_durumu,site_icinde,site_adi,
							aidat,olusturulma_tarihi,guncellenme_tarihi) 
VALUES (last_insert_id(), 2, "Birleşik", 1 ,1 , 1,"Kullanılmıyor" , 1, "Mandalin Park", 1000, NOW(), NOW());                             

COMMIT;

-- Konut SELECT
SELECT * FROM konut_ilan 
INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = konut_ilan.yerleske_id
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id; 

-- UPDATE Konut
UPDATE konut_ilan
INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = konut_ilan.yerleske_id
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
SET kategori_ismi = "Kategori nedir lo", kullanim_durumu = "Deneme 799. 999"
WHERE konut_ilan.konut_id = 1;

-- DELETE Konut
-- Silme işlemi için ilan kategori adresin silinmesi yeterli
DELETE ilan,kategori,adres
FROM konut_ilan 
INNER JOIN yerleske_ilan ON yerleske_ilan.yerleske_id = konut_ilan.yerleske_id
INNER JOIN emlak_ilan ON emlak_ilan.emlak_id = yerleske_ilan.emlak_id
INNER JOIN ilan ON emlak_ilan.ilan_id = ilan.ilan_id
INNER JOIN adres ON ilan.adres_id = adres.adres_id
INNER JOIN kategori ON kategori.kategori_id = ilan.kategori_id
WHERE konut_ilan.konut_id = 1; 


 