DROP TABLE IF EXISTS FAVORI;
DROP TABLE IF EXISTS ILAN;
DROP TABLE IF EXISTS KULLANICI;
DROP TABLE IF EXISTS KATEGORI;
DROP TABLE IF EXISTS ADRES;

CREATE TABLE ADRES (
    adres_id INT AUTO_INCREMENT,
    ulke VARCHAR(25) NOT NULL,
    sehir VARCHAR(25) NOT NULL,
    ilce VARCHAR(25) NOT NULL,
    mahalle VARCHAR(25) NOT NULL,
    cadde VARCHAR(25) NOT NULL,
    sokak VARCHAR(25) NOT NULL,
    bina_no INT NOT NULL,
    daire_no INT, 
    posta_kodu INT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    PRIMARY KEY (adres_id)
);

CREATE TABLE KATEGORI (
    kategori_id INT AUTO_INCREMENT,
    kategori_ismi VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (kategori_id)
);

CREATE TABLE KULLANICI (
    kullanici_id INT AUTO_INCREMENT,
    adres_id INT NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    sifre VARCHAR(255) NOT NULL,
    ad VARCHAR(25) NOT NULL,
    soyad VARCHAR(25) NOT NULL,
    telefon_no VARCHAR(15) NOT NULL,
    kullanici_tipi VARCHAR(20) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (kullanici_id),
    FOREIGN KEY (adres_id) REFERENCES ADRES(adres_id)
);

CREATE TABLE ILAN (
    ilan_id INT AUTO_INCREMENT,
    kullanici_id INT NOT NULL,
    adres_id INT NOT NULL,
    baslik VARCHAR(50) NOT NULL,
    aciklama TEXT NOT NULL,
    fiyat DECIMAL(15,2) NOT NULL,
    kategori_id INT NOT NULL,
    ilan_tipi INT NOT NULL,
    kredi_uygunlugu TINYINT NOT NULL,
    kimden INT NOT NULL,
    takas TINYINT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (ilan_id),
    FOREIGN KEY (kullanici_id) REFERENCES KULLANICI(kullanici_id) ON DELETE CASCADE,
    FOREIGN KEY (adres_id) REFERENCES ADRES(adres_id),
    FOREIGN KEY (kategori_id) REFERENCES KATEGORI(kategori_id)
);

CREATE TABLE FAVORI (
    ilan_id INT NOT NULL,
    kullanici_id INT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (ilan_id, kullanici_id),
    FOREIGN KEY (ilan_id) REFERENCES ILAN(ilan_id) ON DELETE CASCADE,
    FOREIGN KEY (kullanici_id) REFERENCES KULLANICI(kullanici_id) ON DELETE CASCADE
);