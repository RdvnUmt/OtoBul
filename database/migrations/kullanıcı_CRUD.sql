-- CRUD for Kullanici

-- CREATE
INSERT INTO Kullanici (adres_id ,email,sifre,ad,soyad,telefon_no,kullanici_tipi,olusturulma_tarihi,guncellenme_tarihi) VALUES
			(NULL,"yusufmrz22@gmail.com","123456", "Yusuf", "Çoban", "+905424544904", "satıcı", NOW(), NOW());

-- READ
SELECT * FROM Kullanici;

-- UPDATE
UPDATE Kullanici SET sifre=232323 WHERE kullanici.kullanici_id = 3;

-- DELETE
DELETE  FROM Kullanici WHERE kullanici.kullanici_id = 3;