/// İlan Modeli - DB şemasına uyumlu + UI için pratik alanlar
/// Not: details map'i hem "draft key'leri" hem de eski mock key'lerini içerir.
/// Böylece edit seed / listing card gibi yerler kırılmaz.

enum IlanTipi {
  satilik(1, 'Satılık'),
  kiralik(2, 'Kiralık');

  const IlanTipi(this.dbValue, this.label);
  final int dbValue;
  final String label;
}

enum KimdenTipi {
  sahibinden(1, 'Sahibinden'),
  galeriden(2, 'Galeriden');

  const KimdenTipi(this.dbValue, this.label);
  final int dbValue;
  final String label;
}

/// DB: ADRES tablosu ile uyumlu (adres_id / olusturulma_tarihi / updated_at burada tutulmaz)
/// Zorunlu: ulke, sehir, ilce
/// Opsiyonel: mahalle, cadde, sokak, bina_no, daire_no, posta_kodu
class Address {
  static const Object _unset = Object();

  final String ulke;
  final String sehir;
  final String ilce;

  final String? mahalle;
  final String? cadde;
  final String? sokak;
  final int? binaNo;
  final int? daireNo;
  final int? postaKodu;

  const Address({
    required this.ulke,
    required this.sehir,
    required this.ilce,
    this.mahalle,
    this.cadde,
    this.sokak,
    this.binaNo,
    this.daireNo,
    this.postaKodu,
  });

  /// Nullable alanları istenirse "null"a çekebilmek için sentinel kullanan copyWith
  Address copyWith({
    String? ulke,
    String? sehir,
    String? ilce,
    Object? mahalle = _unset,
    Object? cadde = _unset,
    Object? sokak = _unset,
    Object? binaNo = _unset,
    Object? daireNo = _unset,
    Object? postaKodu = _unset,
  }) {
    return Address(
      ulke: ulke ?? this.ulke,
      sehir: sehir ?? this.sehir,
      ilce: ilce ?? this.ilce,
      mahalle: identical(mahalle, _unset) ? this.mahalle : mahalle as String?,
      cadde: identical(cadde, _unset) ? this.cadde : cadde as String?,
      sokak: identical(sokak, _unset) ? this.sokak : sokak as String?,
      binaNo: identical(binaNo, _unset) ? this.binaNo : binaNo as int?,
      daireNo: identical(daireNo, _unset) ? this.daireNo : daireNo as int?,
      postaKodu: identical(postaKodu, _unset) ? this.postaKodu : postaKodu as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'ulke': ulke,
        'sehir': sehir,
        'ilce': ilce,
        'mahalle': mahalle,
        'cadde': cadde,
        'sokak': sokak,
        'bina_no': binaNo,
        'daire_no': daireNo,
        'posta_kodu': postaKodu,
      };
}

/// İlan - ILAN tablosu + UI alanları
class Listing {
  final String id; // DB: ilan_id (INT) ama mockta string kullanıyoruz
  final String title; // baslik
  final String description; // aciklama
  final double price; // fiyat

  /// UI kolaylığı için:
  final String location; // mahalle gibi kısa gösterim
  final String city;
  final String district;

  final Address? address; // DB'ye daha yakın

  final DateTime createdAt; // olusturulma_tarihi
  final DateTime updatedAt; // guncellenme_tarihi

  final String imageUrl;

  /// Kategori (UI)
  /// category: 'emlak' | 'vasita'
  /// subCategory: 'konut' | 'arsa' | 'turistik' | 'devremulk' | 'otomobil' | 'tir' | 'karavan' | 'motosiklet'
  final String category;
  final String subCategory;

  /// ILAN tablosu alanlarını UI'da kullanmak için:
  final IlanTipi ilanTipi;
  final bool krediUygunlugu;
  final KimdenTipi kimden;
  final bool takas;

  /// UI: kartta gösterdiğin string (dropdown ile de uyumlu olmalı)
  final String sellerType;

  final bool isFavorite;

  /// İlanın kategoriye göre tüm detayları (DB + UI uyumlu)
  final Map<String, dynamic> details;

  const Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.city,
    required this.district,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.category,
    required this.subCategory,
    required this.ilanTipi,
    required this.krediUygunlugu,
    required this.kimden,
    required this.takas,
    required this.sellerType,
    this.isFavorite = false,
    this.details = const {},
    this.address,
  });

  Listing copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? location,
    String? city,
    String? district,
    Address? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    String? category,
    String? subCategory,
    IlanTipi? ilanTipi,
    bool? krediUygunlugu,
    KimdenTipi? kimden,
    bool? takas,
    String? sellerType,
    bool? isFavorite,
    Map<String, dynamic>? details,
  }) {
    return Listing(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      location: location ?? this.location,
      city: city ?? this.city,
      district: district ?? this.district,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      ilanTipi: ilanTipi ?? this.ilanTipi,
      krediUygunlugu: krediUygunlugu ?? this.krediUygunlugu,
      kimden: kimden ?? this.kimden,
      takas: takas ?? this.takas,
      sellerType: sellerType ?? this.sellerType,
      isFavorite: isFavorite ?? this.isFavorite,
      details: details ?? this.details,
    );
  }
}

/// Vasıta detayları (DB: Vasita_Ilan + alt tablolar)
/// Not: Form alanlarıyla birebir aynı stringleri kullan (dropdown mismatch olmasın)
class VehicleDetails {
  // Marka/Seri/Model (DB: Marka/Seri/Model tabloları)
  final String markaName;
  final String seriIsmi;
  final String modelIsmi;
  final int? modelYili;
  final String? mensei;

  // Vasita_Ilan
  final String yakitTipi; // Benzin, Dizel, LPG, Hibrit, Elektrik
  final String vites; // Düz, Otomatik, Yarı Otomatik
  final String aracDurumu; // Sıfır, İkinci El
  final int km;
  final int motorGucu; // HP
  final int motorHacmi; // cc
  final String renk;
  final String garanti; // Yok, Var, Üretici, Yetkili Servis
  final bool agirHasarKaydi;
  final String plakaUyruk; // TR, DE, NL

  // Otomobil
  final int? kasaTipi; // 1..5
  final int? cekis; // 1..3

  // Motosiklet
  final int? zamanlamaTipi; // 1..3
  final int? silindirSayisi;
  final int? sogutma; // 1..3

  // Karavan
  final int? yatakSayisiKaravan;
  final int? karavanTuru; // 1..2
  final int? karavanTipi; // 1..3

  // Tır
  final int? kabin; // 1..3
  final int? lastikDurumuYuzde; // 0..100
  final int? yatakSayisiTir;
  final bool? dorse;

  const VehicleDetails({
    required this.markaName,
    required this.seriIsmi,
    required this.modelIsmi,
    this.modelYili,
    this.mensei,
    required this.yakitTipi,
    required this.vites,
    required this.aracDurumu,
    required this.km,
    required this.motorGucu,
    required this.motorHacmi,
    required this.renk,
    required this.garanti,
    required this.agirHasarKaydi,
    required this.plakaUyruk,
    this.kasaTipi,
    this.cekis,
    this.zamanlamaTipi,
    this.silindirSayisi,
    this.sogutma,
    this.yatakSayisiKaravan,
    this.karavanTuru,
    this.karavanTipi,
    this.kabin,
    this.lastikDurumuYuzde,
    this.yatakSayisiTir,
    this.dorse,
  });

  Map<String, dynamic> toMap() => {
        // Draft/UI key'leri
        'markaName': markaName,
        'seriIsmi': seriIsmi,
        'modelIsmi': modelIsmi,
        'modelYili': modelYili,
        'mensei': mensei,
        'yakit': yakitTipi,
        'vites': vites,
        'aracDurumu': aracDurumu,
        'km': km,
        'motorGucu': motorGucu,
        'motorHacmi': motorHacmi,
        'renk': renk,
        'garanti': garanti,
        'agirHasar': agirHasarKaydi,
        'plakaUyruk': plakaUyruk,

        // Alt kategori
        'kasaTipi': kasaTipi,
        'cekis': cekis,
        'zamanlamaTipi': zamanlamaTipi,
        'silindirSayisi': silindirSayisi,
        'sogutma': sogutma,
        'yatakSayisiKaravan': yatakSayisiKaravan,
        'karavanTuru': karavanTuru,
        'karavanTipi': karavanTipi,
        'kabin': kabin,
        'lastikYuzde': lastikDurumuYuzde,
        'yatakSayisiTir': yatakSayisiTir,
        'dorse': dorse,

        // Eski mock key'leri (geri uyumluluk)
        'brand': markaName,
        'model': seriIsmi,
        'year': modelYili,
        'fuel': yakitTipi,
        'gear': vites,
        'enginePower': motorGucu,
        'engineVolume': motorHacmi,
        'color': renk,
        'condition': aracDurumu,
      };
}

/// Emlak detayları (DB: Emlak_Ilan + alt tablolar)
/// Dropdown mismatch olmaması için stringler UI listelerinden seçilmeli.
class PropertyDetails {
  // Emlak_Ilan
  final int m2Brut;
  final int m2Net;
  final String tapuDurumu;

  // Yerleske_Ilan (arsa hariç çoğunda var)
  final String? odaSayisi;
  final int? binaYasi;
  final int? bulunduguKat;
  final int? katSayisi;
  final String? isitma;
  final bool? otopark;

  // Konut_Ilan
  final int? banyoSayisi;
  final String? mutfakTipi;
  final bool? balkon;
  final bool? asansor;
  final bool? esyali;
  final String? kullanimDurumu;
  final bool? siteIcinde;
  final String? siteAdi;
  final int? aidat;

  // Arsa
  final String? imarDurumu;
  final int? adaNo;
  final int? parselNo;
  final int? paftaNo;
  final String? kaksEmsal;
  final String? gabari;

  // Turistik_Tesis
  final int? apartSayisi;
  final int? yatakSayisi;
  final int? acikAlanM2;
  final int? kapaliAlanM2;
  final bool? zeminEtudu;
  final String? yapiDurumu;

  // Devre_Mulk
  final String? devreDonem;

  const PropertyDetails({
    required this.m2Brut,
    required this.m2Net,
    required this.tapuDurumu,
    this.odaSayisi,
    this.binaYasi,
    this.bulunduguKat,
    this.katSayisi,
    this.isitma,
    this.otopark,
    this.banyoSayisi,
    this.mutfakTipi,
    this.balkon,
    this.asansor,
    this.esyali,
    this.kullanimDurumu,
    this.siteIcinde,
    this.siteAdi,
    this.aidat,
    this.imarDurumu,
    this.adaNo,
    this.parselNo,
    this.paftaNo,
    this.kaksEmsal,
    this.gabari,
    this.apartSayisi,
    this.yatakSayisi,
    this.acikAlanM2,
    this.kapaliAlanM2,
    this.zeminEtudu,
    this.yapiDurumu,
    this.devreDonem,
  });

  Map<String, dynamic> toMap() => {
        // Draft/UI key'leri
        'm2Brut': m2Brut,
        'm2Net': m2Net,
        'tapuDurumu': tapuDurumu,

        'odaSayisi': odaSayisi,
        'binaYasi': binaYasi,
        'bulunduguKat': bulunduguKat,
        'katSayisi': katSayisi,
        'isitma': isitma,
        'otopark': otopark,

        'banyoSayisi': banyoSayisi,
        'mutfakTipi': mutfakTipi,
        'balkon': balkon,
        'asansor': asansor,
        'esyali': esyali,
        'kullanimDurumu': kullanimDurumu,
        'siteIcinde': siteIcinde,
        'siteAdi': siteAdi,
        'aidat': aidat,

        'imarDurumu': imarDurumu,
        'adaNo': adaNo,
        'parselNo': parselNo,
        'paftaNo': paftaNo,
        'kaksEmsal': kaksEmsal,
        'gabari': gabari,

        'apartSayisi': apartSayisi,
        'yatakSayisi': yatakSayisi,
        'acikAlanM2': acikAlanM2,
        'kapaliAlanM2': kapaliAlanM2,
        'zeminEtudu': zeminEtudu,
        'yapiDurumu': yapiDurumu,

        'devreDonem': devreDonem,

        // Eski mock key'leri (geri uyumluluk)
        'grossM2': m2Brut,
        'netM2': m2Net,
        'deedStatus': tapuDurumu,
        'roomCount': odaSayisi,
        'buildingAge': binaYasi,
        'floor': bulunduguKat,
        'totalFloors': katSayisi,
        'heating': isitma,
        'hasParking': otopark,
        'hasElevator': asansor,
        'isFurnished': esyali,
      };
}
