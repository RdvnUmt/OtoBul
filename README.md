📝 README — Flask Backend
📌 Project Overview

This project is a Flask-based backend API that provides the core server-side functionality for the application.
The backend includes routing, database connections, validation logic, and business rules required by the system.

🚀 Features

Lightweight and modular Flask architecture
Clean routing and controller structure
Database connection & CRUD operations
Environment variable support
Validation and error-handling middleware
Ready-to-deploy design

🛠 Installation (Backend)

Aşağıdaki adımlarla backend’i lokal ortamda çalıştırabilirsiniz.

1️⃣ Clone the Repository

```bash
git clone <repository-url>
cd <project-folder>
```

2️⃣ Create a Virtual Environment (recommended)

```bash
python -m venv venv
```

Activate environment:

Windows

```bash
venv\Scripts\activate
```

MacOS / Linux

```bash
source venv/bin/activate
```

3️⃣ Install Dependencies

Tüm bağımlılıklar requirements.txt içerisindedir.
Kurmak için:

```bash
pip install -r requirements.txt
```

▶️ Running the Project

Proje, run.py dosyası üzerinden başlatılır.

```bash
python run.py
```

Server başarılı bir şekilde başlatıldığında tipik olarak:

* Running on <http://127.0.0.1:5000/>
* Press CTRL+C to quit

🤝 Contributing

Pull request, issue veya önerileriniz memnuniyetle kabul edilir.

📄 License

This project is licensed under the MIT License.







# OtoBul - Gayrimenkul ve Taşıt İlan Platformu

[cite_start]**OtoBul**, kullanıcıların gayrimenkul ve otomotiv sektöründeki varlıklarını listeleyebildiği, potansiyel alıcıların ise gelişmiş sorgulama ve filtreleme işlemleri yapabildiği, ölçeklenebilir bir e-ticaret platformudur[cite: 11].

[cite_start]Bu proje, **BİL 372 Veritabanı Sistemleri** dersi kapsamında geliştirilmiştir.


## 📋 İçindekiler
- [Proje Hakkında](#proje-hakkında)
- [Özellikler](#özellikler)
- [Teknoloji Yığını](#teknoloji-yığını)
- [Veritabanı Mimarisi](#veritabanı-mimarisi)
- [Kurulum](#kurulum)
- [Ekip Üyeleri](#ekip-üyeleri)

## 🚀 Proje Hakkında

[cite_start]Günümüzde tüketici alışkanlıklarının dijitalleşmesiyle birlikte, alıcı ve satıcıların güvenilir bir ortamda buluşması kritik bir ihtiyaçtır[cite: 8]. [cite_start]OtoBul, geniş yelpazeye yayılan varlık türlerini (Emlak ve Vasıta) tek bir merkezi sistem üzerinde kategorize ederek bu ihtiyaca çözüm sunar[cite: 10].

[cite_start]Projenin temel amacı; veri bütünlüğünün korunduğu, performanslı ve kullanıcı dostu bir ticaret ortamı sağlamaktır[cite: 13].

## ✨ Özellikler

* [cite_start]**Kullanıcı Yönetimi:** Güvenli kayıt, giriş (hashlenmiş şifreler) ve profil yönetimi[cite: 160, 165].
* **İlan Yönetimi:**
    * [cite_start]**Vasıta:** Otomobil, Motosiklet, Karavan ve Tır gibi alt kategorilerde detaylı özellik girişi[cite: 50, 363].
    * [cite_start]**Emlak:** Konut, Arsa, Turistik Tesis gibi türlere özel veri alanları[cite: 60, 297].
* [cite_start]**Gelişmiş Arama ve Filtreleme:** Kategori, şehir, fiyat aralığı ve teknik özelliklere (vites tipi, m², oda sayısı vb.) göre dinamik filtreleme[cite: 199, 226].
* [cite_start]**Favoriler:** Kullanıcıların ilgilendikleri ilanları favori listelerine ekleyebilmesi[cite: 37].
* [cite_start]**Güvenlik:** Yetkilendirme (Authorization) ve sahiplik (Ownership) kontrolleri[cite: 174].

## 🛠 Teknoloji Yığını

[cite_start]Proje, **Backend** ve **Frontend** olmak üzere iki ana modülde geliştirilmiştir[cite: 1089].

### Backend (Python & Flask)
* [cite_start]**Framework:** Flask (MVC mimarisi: Controller -> Service -> Router)[cite: 1092, 1153].
* [cite_start]**ORM/Veritabanı Bağlantısı:** SQLAlchemy, PyMySQL[cite: 1096].
* [cite_start]**Güvenlik:** Flask-Bcrypt (Şifre hashleme), Flask-Session[cite: 1139, 1138].

### Frontend (Flutter)
* [cite_start]**SDK:** Flutter (Web tabanlı uygulama)[cite: 1192].
* **Dil:** Dart.
* [cite_start]**Routing:** go_router[cite: 1208].
* [cite_start]**HTTP İstekleri:** http paketi[cite: 1208].

### Veritabanı (MySQL)
* [cite_start]**VTYS:** MySQL / InnoDB Motoru[cite: 16, 1108].
* [cite_start]**Tasarım:** 3NF ve BCNF prensiplerine tam uyumluluk[cite: 14, 1116].

## 🗄 Veritabanı Mimarisi

[cite_start]Veritabanı tasarımı, karmaşık veri yapılarını yönetmek için **Genelleştirme/Özelleştirme (Supertype/Subtype)** modelini kullanır[cite: 1082].


* **Inheritance (Kalıtım):** `ILAN` tablosu ana varlıktır. `VASITA` ve `EMLAK` tabloları bu tablodan türer. [cite_start]Örneğin bir otomobil ilanı için hiyerarşi şöyledir: `ILAN` -> `VASITA` -> `OTOMOBIL`[cite: 1082, 1085].
* **Kısıtlamalar (Constraints):**
    * [cite_start]Veri bütünlüğü için `ON DELETE CASCADE` kullanılmıştır[cite: 131].
    * [cite_start]Mantıksal kontroller (Örn: $m2\_net \le m2\_brut$ veya $fiyat \ge 0$)[cite: 101, 107].
* [cite_start]**İndeksleme:** Performans için `kategori_isim`, `fiyat`, `il_ilce` gibi sık sorgulanan alanlarda B-Tree indeksleme yapılmıştır[cite: 1115].

## 💻 Kurulum

Projeyi yerel ortamınızda çalıştırmak için aşağıdaki adımları izleyin.

### Gereksinimler
* Python 3.x
* MySQL Server
* Flutter SDK

### 1. Veritabanı Kurulumu
MySQL üzerinde `otobul` isminde bir veritabanı oluşturun ve `database/schema.sql` (varsa) dosyasını import edin.

### 2. Backend Kurulumu

cd backend
pip install -r requirements.txt
# .env dosyasını kendi veritabanı bilgilerinize göre düzenleyin
python run.py

### 2. Backend Kurulumu

cd frontend
flutter pub get
flutter run -d chrome

👥 Ekip Üyeleri
Rıdvan Umut Ünal (221101008)
Yusuf Mirza Çoban (221101003)
Taha Denizbek Tavlan (221101062)



