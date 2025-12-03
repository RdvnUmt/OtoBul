-- Önemli sql statementların after setup!

-- ADRES / KULLANICI / KATEGORİ


-- ADRES
INSERT INTO adres (ulke,sehir,ilce,mahalle,cadde,sokak,bina_no,daire_no, posta_kodu ,olusturulma_tarihi ,guncellenme_tarihi)
VALUES ("Türkiye","Ankara","Çankaya","Beştepe", "Söğütözü","22",12,"612","06560",NOW(), NOW());

-- KULLANICI

INSERT INTO Kullanici (adres_id ,email,sifre,ad,soyad,telefon_no,kullanici_tipi,olusturulma_tarihi,guncellenme_tarihi) VALUES
			(1,"yusufmrz111@gmail.com","123456", "Yusuf", "Çoban", "+905424544904", "satıcı", NOW(), NOW());

-- KATEGORİ

INSERT INTO kategori (kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES 
			("Otomobil", NOW(), NOW());


