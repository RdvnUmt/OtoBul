WEBSİTESİ BACKEND PLANLAMA:

Backend Genel Yapısı :

Gereksinimler:
1-) Authentication
2-) Authorization
3-) Application Interface for MySQL
4-) Debugging and Testing Tools

Kullanılacak Kütüphaneler :
MySQL Kütüphaneleri : (flask_mysqldb , MySQLdb)
Veri Almak için Kullanılacak Kütüphaneler : (requests)
Authentication için : (flask_login)
Testing (emin olmamakla birlikte) : (unittest-pytest)
Developing-Debugging : ( Flask-DebugToolbar )

1-) Authentication:
Kullanıcı yetkilendirmeleriyle ilgili temel işler ve session sistemleri ?
Bu sistemde flask_login ile birlikte kullanıcının giriş-çıkışı sağlanacaktır. flask_sessiona ihtiyaç duyulmadığı için buna gerek duyulmamaktadır.

auth- klasöründe bu işlemler routelar gerçekleştirilecektir.

2-) Authorization
Yetkilendirme kısmında sistemimiz için henüz hangi/lerini kullanacağınımızı bulamadığımız iki authentiacation yöntemi izleyeceğiz bunlardan ilki

A-) Route Decorator ile Authorization:

from functools import wraps
from flask import abort
from flask_login import current_user

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not current_user.is_authenticated or not current_user.is_admin:
            abort(403)  # Yetkisiz
        return f(*args,**kwargs)
    return decorated_function

Burada bir rol oluşturulur ve ardından route’ a atanır ROLE BASE SYSTEM

B-) Controller - Service Modülü İçindeki Yaklaşım :

def update_listing(user, listing, data):
    if listing.owner_id != user.id and not user.is_admin:
        raise PermissionError("Yetkiniz yok")
    listing.update(data)

Burada işleme özel kullanıcının bazı özellikleri barındırıp barındırmamasına bakılır. Permission-Based system

3-) Debugging and Testing Tools :

A-) Testing : (Opsiyonel)
Klasik mantıkla bir testing caseleri oluşturulup unittest ile birlikte veri tabanının kontrolü sağlanabilir.

B-) Debugging: (Kolaylaştırma için)
Flask-DebugToolbar  kullanılarak debug yapacağımız bir sistem oluşturmayı hedefliyoruz.
Belli bir kurulum aşamalarından geçirilip sadece arka plan bağlamında sistemimiz kurulabilir.

4-) API Interface (API) :  (flask_mysqldb , MySQLdb)

Bu sistemimizin en önemli aşamasıdır burada kullanacağımız kütüphaneler ve file systemi kararlaştıracağız.

Klasörler :
-API Klasörü : Modellerle ilgili yapılan işlemler yer almaktadır.
-Auth Klasörü : Auth ile ilgili login logout gibi işlemlerin yeridir.
-Model Klasörü: Database’de kullanılan modellerin model olarak tanımlanıp fonksiyonların da tanımlanabileceği yerlerdir. (Nasıl bölmek gerekicek?)
-Test Klasörü (app dışı)
-Migration Klasörü ? (app dışı)
  
!Model sistemi MVC düzenine göre işlenmelidir ve kullanım buna uygun yapılmalıdır.

Önceki projelerde kullanılan sistemlerin incelenmesi

Javasciprt proje tarzı :

Index route -> (Alt routelar- user,auth,listing, car … route) -> (Alt routeların ilgili controllerları)
Controllerlar asıl işi yapan yada yönlendiren olabilirler belki ama ek yardımcı dosyaları bulunması tavsiye edilir.
Controller => Service => Repository (Modelle ilgili fonksiyonların bulunduğu => Model klasörü

Laravel Sistemi
Routes => Controllers => Models, Middleware, Providers

PROJE YAPISI KARARI :

project/
│
├─ run.py
├─ .env
│
├─ app/
│   ├─ app.py
│   ├─ extensions/           # Baglantılar (db, login manager vs.)
│   │     ├─ db.py
│   │     ├─ login.py
│   │     └─ __init__.py
│   │
│   ├─ blueprints/ (her model için dosyalar)
│   │   ├─ auth/
│   │   │     ├─ __init__.py
│   │   │     ├─ routes.py
│   │   │     ├─ controller.py
│   │   │     └─ service.py
│   │   │
│   │   ├─ user/
│   │   │     ├─ __init__.py
│   │   │     ├─ routes.py
│   │   │     ├─ controller.py
│   │   │     └─ service.py
│   │   │
│   │   ├─ listing/
│   │         ├─ routes.py
│   │         ├─ controller.py
│   │         ├─ service.py
│   │         └─ __init__.py
│   │
│   ├─ models/
│   │     ├─ user.py
│   │     ├─ listing.py
│   │     └─ __init__.py
│   │
│   ├─ policies/
│   │     ├─ auth_policy.py
│   │     └─ listing_policy.py
│   │
│   ├─ middleware/
│   │     └─ ...
│   │
│   ├─ utils/
│   └─ __init__.py
│
├─ migrations/ (opsiyonel)
│
├─ tests/ (opsiyonel)
│
└─ requirements.txt

Middleware kullanımı opsiyonel.
Policy kullanımı projenin biraz daha büyük olabilmesine karşı yetkilendirilme kurallarının kontrolünü sağlamaktır.

Ayrıca model ile diğer auth, user vb … klasörlerin ayrılmasının sebebi dinamiklik sağlamaktır. model-auth kısmında sadece veriler, repository kısmında kullanılacak metodlar (genelde SQL Queryileri) ve  service dosyası business logici ve controller ise gelen isteğe göre çağrı yapmak için kulanılacaktır.

YAPILACAK TAKİP LİSTESİ :

1. Dbeaver- MySQL bağlantısının kurulması X  (25dk)
2. Flask temel ögeleri kuruldu debuggin sistemi kuruldu henüz işlevsiz X (25dk)
3. Debugging testinin kurulması - test kurulma işlemi öğrenildi pytest ve pytest-mock indirildi X
4. SQL-Alchemy kurulumu 
5. Sistemin ufak bir parçasının inşaatı. Kullanılan sınıflar - favori, listing, user,adress, kategori  
6. unittest-pytest kullanılarak test case incelemesi (İleride yapılmasına karar verildi)
7. Oluşacak hatalara karşı debugger kurulumu (yeri değişebilir)
