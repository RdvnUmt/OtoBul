CREATE TABLE Emlak_Ilan (
    emlak_id INT AUTO_INCREMENT PRIMARY KEY,
    ilan_id INT NOT NULL UNIQUE,
    emlak_tipi VARCHAR(50) NOT NULL, 
    m2_brut INT NOT NULL,
    m2_net INT NOT NULL,
    tapu_durumu VARCHAR(50) NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
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
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
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
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
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
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
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
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (yerleske_id) REFERENCES Yerleske_Ilan(yerleske_id) ON DELETE CASCADE
);

CREATE TABLE Devre_Mulk (
    devre_id INT AUTO_INCREMENT PRIMARY KEY,
    yerleske_id INT NOT NULL UNIQUE,
    donem VARCHAR(50) NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (yerleske_id) REFERENCES Yerleske_Ilan(yerleske_id) ON DELETE CASCADE
);