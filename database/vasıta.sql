CREATE TABLE Marka (
    marka_id INT AUTO_INCREMENT PRIMARY KEY,
    marka_name VARCHAR(50) NOT NULL,
    olusturulma_tarihi DATE NOT NULL
);


CREATE TABLE Seri (
    seri_id INT AUTO_INCREMENT PRIMARY KEY,
    marka_id INT NOT NULL,
    seri_ismi VARCHAR(50) NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    FOREIGN KEY (marka_id) REFERENCES Marka(marka_id) ON DELETE CASCADE
);


CREATE TABLE Model (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    seri_id INT NOT NULL,
    model_yili INT,
    mensei VARCHAR(50),
    model_ismi VARCHAR(50),
    olusturulma_tarihi DATE,
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
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (ilan_id) REFERENCES Ilan(ilan_id), 
    FOREIGN KEY (model_id) REFERENCES Model(model_id) ON DELETE CASCADE
);


CREATE TABLE Otomobil(
	otomobil_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL, 
    kasa_tipi INT NOT NULL, 
    cekis INT NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);

CREATE TABLE Motosiklet (
    moto_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    zamanlama_tipi INT NOT NULL, 
    silindir_sayisi SMALLINT NOT NULL,
    sogutma INT NOT NULL, 
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);


CREATE TABLE Karavan (
    kara_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    yatak_sayisi SMALLINT NOT NULL,
    karavan_turu INT NOT NULL,
    karavan_tipi INT NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);


CREATE TABLE Tir (
    tir_id INT AUTO_INCREMENT PRIMARY KEY,
    vasita_id INT NOT NULL,
    kabin INT NOT NULL,
    lastik_durumu_yuzde TINYINT UNSIGNED NOT NULL,
    yatak_sayisi SMALLINT NOT NULL,
    dorse TINYINT(1) NOT NULL,
    olusturulma_tarihi DATE NOT NULL,
    guncellenme_tarihi DATE NOT NULL,
    FOREIGN KEY (vasita_id) REFERENCES Vasita_Ilan(vasita_id) ON DELETE CASCADE
);