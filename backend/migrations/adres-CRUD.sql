use Bil372Proje;

-- CRUD for adres

INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
VALUES ("Türkiye","Ankara","Çankaya","Beştepe", "Söğütözü","22",12,"612","06560",NOW(), NOW());

DELETE FROM adres WHERE adres_id=1;

UPDATE adres SET ulke = 'Portekiz', guncellenme_tarihi = NOW() WHERE adres_id=2;

SELECT * FROM adres WHERE adres_id = 2;




