import '../config/api_config.dart';
import '../models/listing_model.dart';
import 'api_service.dart';

/// İlan Service - İlan CRUD işlemlerini yönetir
class ListingService {
  static final ListingService _instance = ListingService._internal();
  factory ListingService() => _instance;
  ListingService._internal();

  final ApiService _api = ApiService();

  // ═══════════════════════════════════════════════════════════════════════════
  // OTOMOBİL
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm otomobil ilanlarını getir
  Future<List<Listing>> getOtomobilListings() async {
    final response = await _api.get(ApiConfig.otomobilGet);
    if (response.success && response.data is List) {
      return _parseVehicleListings(response.data, 'otomobil');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MOTOSİKLET
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm motosiklet ilanlarını getir
  Future<List<Listing>> getMotosikletListings() async {
    final response = await _api.get(ApiConfig.motosikletGet);
    if (response.success && response.data is List) {
      return _parseVehicleListings(response.data, 'motosiklet');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // KARAVAN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm karavan ilanlarını getir
  Future<List<Listing>> getKaravanListings() async {
    final response = await _api.get(ApiConfig.karavanGet);
    if (response.success && response.data is List) {
      return _parseVehicleListings(response.data, 'karavan');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TIR
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm tır ilanlarını getir
  Future<List<Listing>> getTirListings() async {
    final response = await _api.get(ApiConfig.tirGet);
    if (response.success && response.data is List) {
      return _parseVehicleListings(response.data, 'tir');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // KONUT
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm konut ilanlarını getir
  Future<List<Listing>> getKonutListings() async {
    final response = await _api.get(ApiConfig.konutGet);
    if (response.success && response.data is List) {
      return _parsePropertyListings(response.data, 'konut');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ARSA
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm arsa ilanlarını getir
  Future<List<Listing>> getArsaListings() async {
    final response = await _api.get(ApiConfig.arsaGet);
    if (response.success && response.data is List) {
      return _parsePropertyListings(response.data, 'arsa');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TURİSTİK TESİS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm turistik tesis ilanlarını getir
  Future<List<Listing>> getTuristikListings() async {
    final response = await _api.get(ApiConfig.turistikGet);
    if (response.success && response.data is List) {
      return _parsePropertyListings(response.data, 'turistik');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DEVRE MÜLK
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tüm devre mülk ilanlarını getir
  Future<List<Listing>> getDevremulkListings() async {
    final response = await _api.get(ApiConfig.devreGet);
    if (response.success && response.data is List) {
      return _parsePropertyListings(response.data, 'devremulk');
    }
    return [];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TÜM İLANLAR
  // ═══════════════════════════════════════════════════════════════════════════

  /// Tüm ilanları getir
  Future<List<Listing>> getAllListings() async {
    final results = await Future.wait([
      getOtomobilListings(),
      getMotosikletListings(),
      getKaravanListings(),
      getTirListings(),
      getKonutListings(),
      getArsaListings(),
      getTuristikListings(),
      getDevremulkListings(),
    ]);

    return results.expand((list) => list).toList();
  }

  /// Kategoriye göre ilanları getir
  Future<List<Listing>> getListingsByCategory(String category) async {
    switch (category) {
      case 'emlak':
        final results = await Future.wait([
          getKonutListings(),
          getArsaListings(),
          getTuristikListings(),
          getDevremulkListings(),
        ]);
        return results.expand((list) => list).toList();
      case 'vasita':
        final results = await Future.wait([
          getOtomobilListings(),
          getMotosikletListings(),
          getKaravanListings(),
          getTirListings(),
        ]);
        return results.expand((list) => list).toList();
      default:
        return getAllListings();
    }
  }

  /// Alt kategoriye göre ilanları getir
  Future<List<Listing>> getListingsBySubCategory(String subCategory) async {
    switch (subCategory) {
      case 'otomobil':
        return getOtomobilListings();
      case 'motosiklet':
        return getMotosikletListings();
      case 'karavan':
        return getKaravanListings();
      case 'tir':
        return getTirListings();
      case 'konut':
        return getKonutListings();
      case 'arsa':
        return getArsaListings();
      case 'turistik':
        return getTuristikListings();
      case 'devremulk':
        return getDevremulkListings();
      default:
        return getAllListings();
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PARSER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Vasıta ilanlarını parse et
  List<Listing> _parseVehicleListings(List<dynamic> data, String subCategory) {
    return data.map((item) {
      final map = item as Map<String, dynamic>;
      
      return Listing(
        id: (map['ilan_id'] ?? map['vasita_id'] ?? '0').toString(),
        title: map['baslik'] ?? 'İlan',
        description: map['aciklama'] ?? '',
        price: _parseDouble(map['fiyat']),
        location: map['mahalle'] ?? map['ilce'] ?? '',
        city: map['sehir'] ?? '',
        district: map['ilce'] ?? '',
        createdAt: _parseDateTime(map['olusturulma_tarihi']),
        updatedAt: _parseDateTime(map['guncellenme_tarihi']),
        imageUrl: _getDefaultImage(subCategory),
        category: 'vasita',
        subCategory: subCategory,
        ilanTipi: map['ilan_tipi'] == 'Kiralık' ? IlanTipi.kiralik : IlanTipi.satilik,
        krediUygunlugu: map['kredi_uygunlugu'] == 1,
        kimden: map['kimden'] == 'Galeriden' ? KimdenTipi.galeriden : KimdenTipi.sahibinden,
        takas: map['takas'] == 1,
        sellerType: map['kimden'] ?? 'Sahibinden',
        address: Address(
          ulke: map['ulke'] ?? 'TR',
          sehir: map['sehir'] ?? '',
          ilce: map['ilce'] ?? '',
          mahalle: map['mahalle'],
          cadde: map['cadde'],
          sokak: map['sokak'],
          binaNo: _parseInt(map['bina_no']),
          daireNo: _parseInt(map['daire_no']),
          postaKodu: _parseInt(map['posta_kodu']),
        ),
        details: {
          'markaName': map['marka_name'],
          'seriIsmi': map['seri_ismi'],
          'modelIsmi': map['model_ismi'],
          'modelYili': map['model_yili'],
          'mensei': map['mensei'],
          'yakit': map['yakit_tipi'],
          'vites': map['vites'],
          'aracDurumu': map['arac_durumu'],
          'km': map['km'],
          'motorGucu': map['motor_gucu'],
          'motorHacmi': map['motor_hacmi'],
          'renk': map['renk'],
          'garanti': map['garanti'],
          'agirHasar': map['agir_hasar_kaydi'] == 1,
          'plakaUyruk': map['plaka_uyruk'],
          // Otomobil spesifik
          'kasaTipi': map['kasa_tipi'],
          'cekis': map['cekis'],
          // Motosiklet spesifik
          'zamanlamaTipi': map['zamanlama_tipi'],
          'silindirSayisi': map['silindir_sayisi'],
          'sogutma': map['sogutma'],
          // Karavan spesifik
          'yatakSayisiKaravan': map['yatak_sayisi'],
          'karavanTuru': map['karavan_turu'],
          'karavanTipi': map['karavan_tipi'],
          // Tır spesifik
          'kabin': map['kabin'],
          'lastikYuzde': map['lastik_durumu_yuzde'],
          'yatakSayisiTir': map['yatak_sayisi'],
          'dorse': map['dorse'] == 1,
        },
      );
    }).toList();
  }

  /// Emlak ilanlarını parse et
  List<Listing> _parsePropertyListings(List<dynamic> data, String subCategory) {
    return data.map((item) {
      final map = item as Map<String, dynamic>;
      
      return Listing(
        id: (map['ilan_id'] ?? map['emlak_id'] ?? '0').toString(),
        title: map['baslik'] ?? 'İlan',
        description: map['aciklama'] ?? '',
        price: _parseDouble(map['fiyat']),
        location: map['mahalle'] ?? map['ilce'] ?? '',
        city: map['sehir'] ?? '',
        district: map['ilce'] ?? '',
        createdAt: _parseDateTime(map['olusturulma_tarihi']),
        updatedAt: _parseDateTime(map['guncellenme_tarihi']),
        imageUrl: _getDefaultImage(subCategory),
        category: 'emlak',
        subCategory: subCategory,
        ilanTipi: map['ilan_tipi'] == 'Kiralık' ? IlanTipi.kiralik : IlanTipi.satilik,
        krediUygunlugu: map['kredi_uygunlugu'] == 1,
        kimden: map['kimden'] == 'Galeriden' ? KimdenTipi.galeriden : KimdenTipi.sahibinden,
        takas: map['takas'] == 1,
        sellerType: map['kimden'] ?? 'Sahibinden',
        address: Address(
          ulke: map['ulke'] ?? 'TR',
          sehir: map['sehir'] ?? '',
          ilce: map['ilce'] ?? '',
          mahalle: map['mahalle'],
          cadde: map['cadde'],
          sokak: map['sokak'],
          binaNo: _parseInt(map['bina_no']),
          daireNo: _parseInt(map['daire_no']),
          postaKodu: _parseInt(map['posta_kodu']),
        ),
        details: {
          'm2Brut': map['m2_brut'],
          'm2Net': map['m2_net'],
          'tapuDurumu': map['tapu_durumu'],
          // Yerleşke spesifik
          'odaSayisi': map['oda_sayisi'],
          'binaYasi': map['bina_yasi'],
          'bulunduguKat': map['bulundugu_kat'],
          'katSayisi': map['kat_sayisi'],
          'isitma': map['isitma'],
          'otopark': map['otopark'] == 1,
          // Konut spesifik
          'banyoSayisi': map['banyo_sayisi'],
          'mutfakTipi': map['mutfak_tipi'],
          'balkon': map['balkon'] == 1,
          'asansor': map['asansor'] == 1,
          'esyali': map['esyali'] == 1,
          'kullanimDurumu': map['kullanim_durumu'],
          'siteIcinde': map['site_icinde'] == 1,
          'siteAdi': map['site_adi'],
          'aidat': map['aidat'],
          // Arsa spesifik
          'imarDurumu': map['imar_durumu'],
          'adaNo': map['ada_no'],
          'parselNo': map['parsel_no'],
          'paftaNo': map['pafta_no'],
          'kaksEmsal': map['kaks_emsal'],
          'gabari': map['gabari'],
          // Turistik Tesis spesifik
          'apartSayisi': map['apart_sayisi'],
          'yatakSayisi': map['yatak_sayisi'],
          'acikAlanM2': map['acik_alan_m2'],
          'kapaliAlanM2': map['kapali_alan_m2'],
          'zeminEtudu': map['zemin_etudu'] == 1,
          'yapiDurumu': map['yapi_durumu'],
          // Devre Mülk spesifik
          'devreDonem': map['donem'],
        },
      );
    }).toList();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  String _getDefaultImage(String subCategory) {
    switch (subCategory) {
      case 'otomobil':
        return 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400';
      case 'motosiklet':
        return 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400';
      case 'karavan':
        return 'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?w=400';
      case 'tir':
        return 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=400';
      case 'konut':
        return 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400';
      case 'arsa':
        return 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400';
      case 'turistik':
        return 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400';
      case 'devremulk':
        return 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400';
      default:
        return 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400';
    }
  }
}

