-- Database Table Creation Code
-- CREATE DATABASE Bil372Proje;


-- Database Table Creation Code

CREATE DATABASE Bil372Proje;
use Bil372Proje;

-- Database Table Creation Code

CREATE TABLE Adres (
    adres_id INT AUTO_INCREMENT,
    ulke VARCHAR(25) NOT NULL,
    sehir VARCHAR(25) NOT NULL,
    ilce VARCHAR(25) NOT NULL,
    mahalle VARCHAR(25) NOT NULL,
    cadde VARCHAR(25) NOT NULL,
    sokak VARCHAR(25) NOT NULL,
    bina_no INT NOT NULL,
    daire_no INT, 
    posta_kodu VARCHAR(10) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (adres_id)
);

CREATE TABLE Kategori (
    kategori_id INT AUTO_INCREMENT,
    kategori_ismi VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (kategori_id)
);

CREATE TABLE Kullanici (
    kullanici_id INT AUTO_INCREMENT,
    adres_id INT,
    email VARCHAR(50) NOT NULL UNIQUE,
    sifre VARCHAR(255) NOT NULL,
    ad VARCHAR(25) NOT NULL,
    soyad VARCHAR(25) NOT NULL,
    telefon_no VARCHAR(15) NOT NULL,
    kullanici_tipi VARCHAR(20) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (kullanici_id),
    FOREIGN KEY (adres_id) REFERENCES Adres(adres_id)
);

CREATE TABLE Ilan (
    ilan_id INT AUTO_INCREMENT,
    kullanici_id INT NOT NULL,
    adres_id INT NOT NULL,
    baslik VARCHAR(50) NOT NULL,
    aciklama TEXT NOT NULL,
    fiyat DECIMAL(15,2) NOT NULL,
    kategori_id INT NOT NULL,
    ilan_tipi VARCHAR(50) NOT NULL,
    kredi_uygunlugu TINYINT NOT NULL,
    kimden VARCHAR(50) NOT NULL,
    takas TINYINT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (ilan_id),
    FOREIGN KEY (kullanici_id) REFERENCES Kullanici(kullanici_id) ON DELETE CASCADE,
    FOREIGN KEY (adres_id) REFERENCES Adres(adres_id),
    FOREIGN KEY (kategori_id) REFERENCES Kategori(kategori_id) 
);

CREATE TABLE Favori (
    ilan_id INT NOT NULL,
    kullanici_id INT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    PRIMARY KEY (ilan_id, kullanici_id),
    FOREIGN KEY (ilan_id) REFERENCES Ilan(ilan_id) ON DELETE CASCADE,
    FOREIGN KEY (kullanici_id) REFERENCES Kullanici(kullanici_id) ON DELETE CASCADE
);

CREATE TABLE Emlak_Ilan (
    emlak_id INT AUTO_INCREMENT PRIMARY KEY,
    ilan_id INT NOT NULL UNIQUE,
    emlak_tipi VARCHAR(50) NOT NULL, 
    m2_brut INT NOT NULL,
    m2_net INT NOT NULL,
    tapu_durumu VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (ilan_id) REFERENCES Ilan(ilan_id) ON DELETE CASCADE
);

CREATE TABLE Arsa (
    arsa_id INT AUTO_INCREMENT PRIMARY KEY,
    emlak_id INT NOT NULL UNIQUE,
    imar_durumu VARCHAR(50), 
    ada_no INT NOT NULL,
    parsel_no INT NOT NULL,
    pafta_no INT NOT NULL, 
    kaks_emsal VARCHAR(50), 
    gabari VARCHAR(50),
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (emlak_id) REFERENCES Emlak_Ilan(emlak_id) ON DELETE CASCADE
);

CREATE TABLE Yerleske_Ilan (
    yerleske_id INT AUTO_INCREMENT PRIMARY KEY,
    emlak_id INT NOT NULL UNIQUE,
    yerleske_tipi VARCHAR(25) NOT NULL,	
    oda_sayisi VARCHAR(10) NOT NULL,
    bina_yasi SMALLINT NOT NULL, 
    bulundugu_kat SMALLINT NOT NULL, 
    kat_sayisi SMALLINT NOT NULL,
    isitma VARCHAR(50) NOT NULL,
    otopark TINYINT(1) NOT NULL, 
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (emlak_id) REFERENCES Emlak_Ilan(emlak_id) ON DELETE CASCADE
);

CREATE TABLE Konut_Ilan (
    konut_id INT AUTO_INCREMENT PRIMARY KEY,
    yerleske_id INT NOT NULL UNIQUE,
    banyo_sayisi INT NOT NULL,
    mutfak_tipi VARCHAR(50) NOT NULL,
    balkon TINYINT(1) NOT NULL,
    asansor TINYINT(1) NOT NULL,
    esyali TINYINT(1) NOT NULL,
    kullanim_durumu VARCHAR(50) NOT NULL, 
    site_icinde TINYINT(1) NOT NULL,
    site_adi VARCHAR(100) NOT NULL,
    aidat INT NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (yerleske_id) REFERENCES Yerleske_Ilan(yerleske_id) ON DELETE CASCADE
);

CREATE TABLE Turistik_Tesis (
    turistik_id INT AUTO_INCREMENT PRIMARY KEY,
    yerleske_id INT NOT NULL UNIQUE,
    apart_sayisi INT,
    yatak_sayisi INT,
    acik_alan_m2 INT,
    kapali_alan_m2 INT,
    zemin_etudu TINYINT(1),
    yapi_durumu VARCHAR(50),
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (yerleske_id) REFERENCES Yerleske_Ilan(yerleske_id) ON DELETE CASCADE
);

CREATE TABLE Devre_Mulk (
    devre_id INT AUTO_INCREMENT PRIMARY KEY,
    yerleske_id INT NOT NULL UNIQUE,
    donem VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (yerleske_id) REFERENCES Yerleske_Ilan(yerleske_id) ON DELETE CASCADE
);


CREATE TABLE Marka (
    marka_id INT AUTO_INCREMENT PRIMARY KEY,
    marka_name VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL
);


CREATE TABLE Seri (
    seri_id INT AUTO_INCREMENT PRIMARY KEY,
    marka_id INT NOT NULL,
    seri_ismi VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (marka_id) REFERENCES Marka(marka_id) ON DELETE CASCADE
);


CREATE TABLE Model (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    seri_id INT NOT NULL,
    model_yili INT,
    mensei VARCHAR(50),
    model_ismi VARCHAR(50),
    olusturulma_tarihi TIMESTAMP,
    FOREIGN KEY (seri_id) REFERENCES Seri(seri_id) ON DELETE CASCADE
);


CREATE TABLE Vasita_Ilan (
    vasita_id INT AUTO_INCREMENT PRIMARY KEY,
    ilan_id INT NOT NULL, 
    vasita_tipi VARCHAR(50) NOT NULL,
    model_id INT NOT NULL,
    yakit_tipi VARCHAR(50) NOT NULL,
    vites VARCHAR(50) NOT NULL,
    arac_durumu VARCHAR(50) NOT NULL,
    km INT NOT NULL,
    motor_gucu INT NOT NULL,
    motor_hacmi INT NOT NULL,
    renk VARCHAR(50) NOT NULL,
    garanti VARCHAR(50) NOT NULL,
    agir_hasar_kaydi TINYINT(1) NOT NULL, 
    plaka_uyruk VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (ilan_id) REFERENCES Ilan(ilan_id) ON DELETE CASCADE, 
    FOREIGN KEY (model_id) REFERENCES Model(model_id) ON DELETE CASCADE
);


CREATE TABLE Otomobil(
	otomobil_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL, 
    kasa_tipi VARCHAR(50) NOT NULL, 
    cekis VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);

CREATE TABLE Motosiklet (
    moto_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    zamanlama_tipi VARCHAR(50) NOT NULL, 
    silindir_sayisi SMALLINT NOT NULL,
    sogutma VARCHAR(50) NOT NULL, 
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);


CREATE TABLE Karavan (
    kara_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    yatak_sayisi SMALLINT NOT NULL,
    karavan_turu VARCHAR(50) NOT NULL,
    karavan_tipi VARCHAR(50) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);


CREATE TABLE Tir (
    tir_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    kabin VARCHAR(50) NOT NULL,
    lastik_durumu_yuzde TINYINT UNSIGNED NOT NULL,
    yatak_sayisi SMALLINT NOT NULL,
    dorse TINYINT(1) NOT NULL,
    olusturulma_tarihi TIMESTAMP NOT NULL,
    guncellenme_tarihi TIMESTAMP NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);


