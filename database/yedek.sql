USE Bil372Proje;

-- =====================================================
-- ADRES VERİLERİ
-- =====================================================
INSERT INTO Adres (ulke, sehir, ilce, mahalle, cadde, sokak, bina_no, daire_no, posta_kodu, olusturulma_tarihi, guncellenme_tarihi) VALUES
('TR', 'İstanbul', 'Kadıköy', 'Moda', 'Moda Caddesi', '1. Sokak', 12, 8, '34710', NOW(), NOW()),
('TR', 'İstanbul', 'Beşiktaş', 'Levazım', 'Büyükdere Cd.', 'Karanfil Sk.', 35, NULL, '34330', NOW(), NOW()),
('TR', 'Ankara', 'Çankaya', 'Kızılay', 'Atatürk Bulvarı', 'Meşrutiyet Sk.', 21, NULL, '06420', NOW(), NOW()),
('TR', 'İzmir', 'Karşıyaka', 'Bostanlı', 'Cemal Gürsel Cd.', 'Park Sk.', 5, NULL, '35590', NOW(), NOW()),
('TR', 'Bursa', 'Nilüfer', 'İhsaniye', 'FSM Bulvarı', 'Gökkuşağı Sk.', 4, NULL, '16130', NOW(), NOW()),
('TR', 'Antalya', 'Muratpaşa', 'Kaleiçi', 'Hesapçı Sok.', 'Kılınçarslan Sk.', 19, NULL, '07100', NOW(), NOW()),
('TR', 'Muğla', 'Bodrum', 'Yalıkavak', 'Atatürk Caddesi', 'Sahil Sokak', 1, NULL, '48990', NOW(), NOW()),
('TR', 'Kocaeli', 'Gebze', 'Köşklü Çeşme', 'D-100 Yan Yol', 'Sanayi Sk.', 18, NULL, '41400', NOW(), NOW());

-- =====================================================
-- KATEGORİ VERİLERİ
-- =====================================================
INSERT INTO Kategori (kategori_ismi, olusturulma_tarihi, guncellenme_tarihi) VALUES
('Otomobil', NOW(), NOW()),
('Motosiklet', NOW(), NOW()),
('Karavan', NOW(), NOW()),
('Tır', NOW(), NOW()),
('Konut', NOW(), NOW()),
('Arsa', NOW(), NOW()),
('Turistik Tesis', NOW(), NOW()),
('Devre Mülk', NOW(), NOW());

-- =====================================================
-- KULLANICI VERİLERİ
-- =====================================================
INSERT INTO Kullanici (adres_id, email, sifre, ad, soyad, telefon_no, kullanici_tipi, olusturulma_tarihi, guncellenme_tarihi) VALUES
(1, 'ahmet@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/X4.TA4M1wBQVNSJd.', 'Ahmet', 'Yılmaz', '05551234567', 'bireysel', NOW(), NOW()),
(2, 'mehmet@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/X4.TA4M1wBQVNSJd.', 'Mehmet', 'Kaya', '05559876543', 'kurumsal', NOW(), NOW()),
(3, 'ayse@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/X4.TA4M1wBQVNSJd.', 'Ayşe', 'Demir', '05553334455', 'bireysel', NOW(), NOW());

-- =====================================================
-- MARKA / SERİ / MODEL VERİLERİ (Vasıta için)
-- =====================================================
INSERT INTO Marka (marka_name, olusturulma_tarihi) VALUES
('BMW', NOW()),
('Mercedes', NOW()),
('Audi', NOW()),
('Volkswagen', NOW()),
('Renault', NOW()),
('Honda', NOW()),
('Yamaha', NOW()),
('Hobby', NOW()),
('Volvo', NOW());

INSERT INTO Seri (marka_id, seri_ismi, olusturulma_tarihi) VALUES
(1, '3 Serisi', NOW()),
(1, '5 Serisi', NOW()),
(2, 'C Serisi', NOW()),
(2, 'Actros', NOW()),
(3, 'A4', NOW()),
(4, 'Golf', NOW()),
(5, 'Clio', NOW()),
(6, 'CBR', NOW()),
(7, 'MT', NOW()),
(8, 'De Luxe', NOW()),
(9, 'FH', NOW());

INSERT INTO Model (seri_id, model_yili, mensei, model_ismi, olusturulma_tarihi) VALUES
(1, 2021, 'Almanya', '320i M Sport', NOW()),
(1, 2020, 'Almanya', '320d', NOW()),
(2, 2022, 'Almanya', '530i', NOW()),
(3, 2021, 'Almanya', 'C200', NOW()),
(4, 2018, 'Almanya', '1841', NOW()),
(5, 2022, 'Almanya', '45 TFSI', NOW()),
(6, 2020, 'Almanya', '1.4 TSI', NOW()),
(7, 2022, 'Fransa', '1.0 TCe', NOW()),
(8, 2022, 'Japonya', '650R ABS', NOW()),
(9, 2021, 'Japonya', '07', NOW()),
(10, 2020, 'Almanya', '495 UL', NOW()),
(11, 2019, 'İsveç', '500', NOW());

-- =====================================================
-- İLAN VERİLERİ
-- =====================================================
INSERT INTO Ilan (kullanici_id, adres_id, baslik, aciklama, fiyat, kategori_id, ilan_tipi, kredi_uygunlugu, kimden, takas, olusturulma_tarihi, guncellenme_tarihi) VALUES
-- Otomobil İlanları
(1, 2, 'BMW 320i M Sport 2021', 'Hatasız, bakımlı, dolu paket. Garaj aracı.', 2350000.00, 1, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),
(2, 3, 'Mercedes C200 2021', 'Sıfır ayarında, garantili araç.', 2100000.00, 1, 'Satılık', 1, 'Galeriden', 1, NOW(), NOW()),
(1, 4, 'Volkswagen Golf 1.4 TSI', 'Ekonomik, bakımlı, az yakıt.', 980000.00, 1, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),
(3, 1, 'Renault Clio Günlük Kiralık', 'Şehir içi ekonomik, teslimat opsiyonlu.', 1250.00, 1, 'Kiralık', 0, 'Galeriden', 0, NOW(), NOW()),

-- Motosiklet İlanları
(1, 4, 'Honda CBR 650R ABS', 'Bakımlı, az km, temiz. Garaj motoru.', 485000.00, 2, 'Satılık', 0, 'Sahibinden', 0, NOW(), NOW()),
(2, 5, 'Yamaha MT-07 2021', 'Garaj motoru, bakımlı, expertiz mevcut.', 395000.00, 2, 'Satılık', 1, 'Galeriden', 1, NOW(), NOW()),

-- Karavan İlanları
(1, 5, 'Hobby De Luxe 495 UL Karavan', 'Bakımlı, 4 kişilik, çekme karavan. Kamp ekipmanı dahil.', 1850000.00, 3, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),

-- Tır İlanları
(2, 8, 'Volvo FH 500 Euro 6', 'Orijinal km, bakımlı, dorseli. Yurt dışı çekicisi.', 4100000.00, 4, 'Satılık', 1, 'Galeriden', 1, NOW(), NOW()),
(3, 2, 'Mercedes Actros 1841 Çekici', 'Faal, temiz, servis bakımlı.', 3200000.00, 4, 'Satılık', 0, 'Sahibinden', 1, NOW(), NOW()),

-- Konut İlanları
(1, 1, '3+1 Lüks Daire Deniz Manzaralı', 'Kadıköy Moda''da, rezidansta, deniz manzaralı daire.', 4850000.00, 5, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),
(2, 3, '2+1 Eşyalı Daire Kiralık', 'Metroya yakın, eşyalı, bakımlı daire.', 28000.00, 5, 'Kiralık', 0, 'Sahibinden', 0, NOW(), NOW()),

-- Arsa İlanları
(1, 7, 'İmarlı Villa Arsası 500 m²', 'Yalıkavak''ta denize yakın, imarlı arsa. Yatırımlık.', 8500000.00, 6, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),

-- Turistik Tesis İlanları
(2, 6, '12 Odalı Butik Otel Satılık', 'Kaleiçi''nde işlek konumda, ruhsatlı butik otel.', 28000000.00, 7, 'Satılık', 1, 'Sahibinden', 0, NOW(), NOW()),

-- Devre Mülk İlanları
(3, 7, 'Bodrum Devre Mülk (Temmuz)', 'Tesis içinde, yaz dönemi devre mülk hakkı Jean Nouvel tasarımı.', 185000.00, 8, 'Satılık', 0, 'Sahibinden', 0, NOW(), NOW());

-- =====================================================
-- VASITA İLAN VERİLERİ
-- =====================================================
INSERT INTO Vasita_Ilan (ilan_id, vasita_tipi, model_id, yakit_tipi, vites, arac_durumu, km, motor_gucu, motor_hacmi, renk, garanti, agir_hasar_kaydi, plaka_uyruk, olusturulma_tarihi, guncellenme_tarihi) VALUES
(1, 'Otomobil', 1, 'Benzin', 'Otomatik', 'İkinci El', 45000, 170, 1998, 'Siyah', 'Yetkili Servis', 0, 'TR', NOW(), NOW()),
(2, 'Otomobil', 4, 'Benzin', 'Otomatik', 'İkinci El', 32000, 156, 1496, 'Beyaz', 'Üretici', 0, 'TR', NOW(), NOW()),
(3, 'Otomobil', 7, 'Benzin', 'Düz', 'İkinci El', 68000, 150, 1395, 'Gri', 'Yok', 0, 'TR', NOW(), NOW()),
(4, 'Otomobil', 8, 'Benzin', 'Otomatik', 'İkinci El', 32000, 90, 999, 'Gri', 'Yok', 0, 'TR', NOW(), NOW()),
(5, 'Motosiklet', 9, 'Benzin', 'Düz', 'İkinci El', 8000, 95, 649, 'Kırmızı', 'Yok', 0, 'TR', NOW(), NOW()),
(6, 'Motosiklet', 10, 'Benzin', 'Düz', 'İkinci El', 15000, 73, 689, 'Mavi', 'Yok', 0, 'TR', NOW(), NOW()),
(7, 'Karavan', 11, 'Dizel', 'Düz', 'İkinci El', 12000, 130, 2198, 'Beyaz', 'Yok', 0, 'TR', NOW(), NOW()),
(8, 'Tır', 12, 'Dizel', 'Otomatik', 'İkinci El', 380000, 500, 12777, 'Gri', 'Yok', 0, 'TR', NOW(), NOW()),
(9, 'Tır', 5, 'Dizel', 'Otomatik', 'İkinci El', 420000, 410, 12809, 'Beyaz', 'Yok', 0, 'TR', NOW(), NOW());

-- =====================================================
-- OTOMOBİL DETAY VERİLERİ
-- =====================================================
INSERT INTO Otomobil (vasita_id, kasa_tipi, cekis, olusturulma_tarihi, guncellenme_tarihi) VALUES
(1, 'Sedan', 'Arkadan', NOW(), NOW()),
(2, 'Sedan', 'Arkadan', NOW(), NOW()),
(3, 'Hatchback', 'Önden', NOW(), NOW()),
(4, 'Hatchback', 'Önden', NOW(), NOW());

-- =====================================================
-- MOTOSİKLET DETAY VERİLERİ
-- =====================================================
INSERT INTO Motosiklet (vasita_id, zamanlama_tipi, silindir_sayisi, sogutma, olusturulma_tarihi, guncellenme_tarihi) VALUES
(5, '4 Zamanlı', 4, 'Sıvı', NOW(), NOW()),
(6, '4 Zamanlı', 2, 'Sıvı', NOW(), NOW());

-- =====================================================
-- KARAVAN DETAY VERİLERİ
-- =====================================================
INSERT INTO Karavan (vasita_id, yatak_sayisi, karavan_turu, karavan_tipi, olusturulma_tarihi, guncellenme_tarihi) VALUES
(7, 4, 'Çekme Karavan', 'Alçak Tavan', NOW(), NOW());

-- =====================================================
-- TIR DETAY VERİLERİ
-- =====================================================
INSERT INTO Tir (vasita_id, kabin, lastik_durumu_yuzde, yatak_sayisi, dorse, olusturulma_tarihi, guncellenme_tarihi) VALUES
(8, 'Uzun Kabin', 90, 1, 1, NOW(), NOW()),
(9, 'Kısa Kabin', 85, 2, 0, NOW(), NOW());

-- =====================================================
-- EMLAK İLAN VERİLERİ
-- =====================================================
INSERT INTO Emlak_Ilan (ilan_id, emlak_tipi, m2_brut, m2_net, tapu_durumu, olusturulma_tarihi, guncellenme_tarihi) VALUES
(10, 'Konut', 145, 130, 'Kat Mülkiyeti', NOW(), NOW()),
(11, 'Konut', 85, 75, 'Kat Mülkiyeti', NOW(), NOW()),
(12, 'Arsa', 500, 500, 'Müstakil Tapu', NOW(), NOW()),
(13, 'Turistik Tesis', 650, 520, 'Kat İrtifakı', NOW(), NOW()),
(14, 'Devre Mülk', 65, 55, 'Kat Mülkiyeti', NOW(), NOW());

-- =====================================================
-- YERLEŞKE İLAN VERİLERİ (Konut, Turistik, Devre Mülk için)
-- =====================================================
INSERT INTO Yerleske_Ilan (emlak_id, yerleske_tipi, oda_sayisi, bina_yasi, bulundugu_kat, kat_sayisi, isitma, otopark, olusturulma_tarihi, guncellenme_tarihi) VALUES
(1, 'Daire', '3+1', 2, 8, 12, 'Merkezi', 1, NOW(), NOW()),
(2, 'Daire', '2+1', 5, 3, 8, 'Doğalgaz', 0, NOW(), NOW()),
(4, 'Otel', '6+', 30, 2, 2, 'Klima', 1, NOW(), NOW()),
(5, 'Daire', '1+1', 8, 1, 3, 'Klima', 1, NOW(), NOW());

-- =====================================================
-- KONUT İLAN VERİLERİ
-- =====================================================
INSERT INTO Konut_Ilan (yerleske_id, banyo_sayisi, mutfak_tipi, balkon, asansor, esyali, kullanim_durumu, site_icinde, site_adi, aidat, olusturulma_tarihi, guncellenme_tarihi) VALUES
(1, 2, 'Kapalı', 1, 1, 0, 'Boş', 1, 'Moda Rezidans', 750, NOW(), NOW()),
(2, 1, 'Amerikan', 0, 1, 1, 'Kiracı Oturuyor', 0, '', 0, NOW(), NOW());

-- =====================================================
-- ARSA VERİLERİ
-- =====================================================
INSERT INTO Arsa (emlak_id, imar_durumu, ada_no, parsel_no, pafta_no, kaks_emsal, gabari, olusturulma_tarihi, guncellenme_tarihi) VALUES
(3, 'İmarlı', 45, 124, 7, '0.30', '7.50', NOW(), NOW());

-- =====================================================
-- TURİSTİK TESİS VERİLERİ
-- =====================================================
INSERT INTO Turistik_Tesis (yerleske_id, apart_sayisi, yatak_sayisi, acik_alan_m2, kapali_alan_m2, zemin_etudu, yapi_durumu, olusturulma_tarihi, guncellenme_tarihi) VALUES
(3, 0, 24, 200, 450, 1, 'Ruhsatlı', NOW(), NOW());

-- =====================================================
-- DEVRE MÜLK VERİLERİ
-- =====================================================
INSERT INTO Devre_Mulk (yerleske_id, donem, olusturulma_tarihi, guncellenme_tarihi) VALUES
(4, 'Yaz', NOW(), NOW());

-- =====================================================
-- FAVORİ VERİLERİ
-- =====================================================
INSERT INTO Favori (ilan_id, kullanici_id, olusturulma_tarihi) VALUES
(1, 2, NOW()),
(1, 3, NOW()),
(5, 1, NOW()),
(10, 2, NOW());

SELECT 'Seed data başarıyla eklendi!' AS mesaj;

