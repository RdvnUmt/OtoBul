import '../config/api_config.dart';
import '../models/listing_model.dart';
import 'api_service.dart';

/// Filtreleme ve Pagination için Response Model
class ListingResponse {
  final List<Listing> listings;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final int pageSize;

  ListingResponse({
    required this.listings,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
  });
}

/// Filtreleme parametreleri - Her alt kategori için 3 filtre
class FilterParams {
  // Ortak filtre (tüm kategoriler)
  final String? ilanTipi; // Satılık/Kiralık
  
  // Konut filtreleri (3 adet)
  final String? odaSayisi;
  final String? isitma;
  final String? kullanimDurumu;
  
  // Arsa filtreleri (3 adet)
  final String? imarDurumu;
  final String? tapuDurumu;
  final String? emlakTipi;
  
  // Turistik filtreleri (3 adet)
  final String? turistikTipi;
  final String? yildizSayisi;
  final String? konumTipi;
  
  // Devre Mülk filtreleri (3 adet)
  final String? sezon;
  final String? hafta;
  final String? bolge;
  
  // Otomobil filtreleri (3 adet)
  final String? vites;
  final String? yakitTipi;
  final String? kasaTipi;
  
  // Motosiklet filtreleri (3 adet)
  final String? motorTipi;
  final String? motorHacmi;
  final String? motorMarka;
  
  // Karavan filtreleri (3 adet)
  final String? karavanTipi;
  final String? karavanMarka;
  final String? yatakKapasitesi;
  
  // Tır filtreleri (3 adet)
  final String? tirTipi;
  final String? tirMarka;
  final String? dingil;
  
  // Sıralama
  final String? sortBy;
  final String? sortOrder;
  
  // Pagination
  final int page;
  final int pageSize;

  const FilterParams({
    this.ilanTipi,
    this.odaSayisi,
    this.isitma,
    this.kullanimDurumu,
    this.imarDurumu,
    this.tapuDurumu,
    this.emlakTipi,
    this.turistikTipi,
    this.yildizSayisi,
    this.konumTipi,
    this.sezon,
    this.hafta,
    this.bolge,
    this.vites,
    this.yakitTipi,
    this.kasaTipi,
    this.motorTipi,
    this.motorHacmi,
    this.motorMarka,
    this.karavanTipi,
    this.karavanMarka,
    this.yatakKapasitesi,
    this.tirTipi,
    this.tirMarka,
    this.dingil,
    this.sortBy,
    this.sortOrder,
    this.page = 1,
    this.pageSize = 10,
  });

  /// Backend'in beklediği formatta where objesi oluştur
  Map<String, dynamic> toBackendMap(String subCategory) {
    final whereMap = <String, dynamic>{};
    
    // Ortak filtre
    if (ilanTipi != null && ilanTipi!.isNotEmpty) {
      whereMap['ilan_tipi'] = ilanTipi;
    }
    
    // Kategoriye göre spesifik filtreler
    switch (subCategory) {
      case 'konut':
        if (odaSayisi != null && odaSayisi!.isNotEmpty) whereMap['oda_sayisi'] = odaSayisi;
        if (isitma != null && isitma!.isNotEmpty) whereMap['isitma'] = isitma;
        if (kullanimDurumu != null && kullanimDurumu!.isNotEmpty) whereMap['kullanim_durumu'] = kullanimDurumu;
        break;
      case 'arsa':
        if (imarDurumu != null && imarDurumu!.isNotEmpty) whereMap['imar_durumu'] = imarDurumu;
        if (tapuDurumu != null && tapuDurumu!.isNotEmpty) whereMap['tapu_durumu'] = tapuDurumu;
        if (emlakTipi != null && emlakTipi!.isNotEmpty) whereMap['emlak_tipi'] = emlakTipi;
        break;
      case 'turistik':
        if (turistikTipi != null && turistikTipi!.isNotEmpty) whereMap['yerleske_tipi'] = turistikTipi;
        if (yildizSayisi != null && yildizSayisi!.isNotEmpty) whereMap['yildiz_sayisi'] = yildizSayisi;
        if (konumTipi != null && konumTipi!.isNotEmpty) whereMap['konum_tipi'] = konumTipi;
        break;
      case 'devremulk':
        if (sezon != null && sezon!.isNotEmpty) whereMap['sezon'] = sezon;
        if (hafta != null && hafta!.isNotEmpty) whereMap['hafta'] = hafta;
        if (bolge != null && bolge!.isNotEmpty) whereMap['bolge'] = bolge;
        break;
      case 'otomobil':
        if (vites != null && vites!.isNotEmpty) whereMap['vites'] = vites;
        if (yakitTipi != null && yakitTipi!.isNotEmpty) whereMap['yakit_tipi'] = yakitTipi;
        if (kasaTipi != null && kasaTipi!.isNotEmpty) whereMap['kasa_tipi'] = kasaTipi;
        break;
      case 'motosiklet':
        if (motorTipi != null && motorTipi!.isNotEmpty) whereMap['motor_tipi'] = motorTipi;
        if (motorHacmi != null && motorHacmi!.isNotEmpty) whereMap['motor_hacmi'] = motorHacmi;
        if (motorMarka != null && motorMarka!.isNotEmpty) whereMap['marka_name'] = motorMarka;
        break;
      case 'karavan':
        if (karavanTipi != null && karavanTipi!.isNotEmpty) whereMap['karavan_tipi'] = karavanTipi;
        if (karavanMarka != null && karavanMarka!.isNotEmpty) whereMap['marka_name'] = karavanMarka;
        if (yatakKapasitesi != null && yatakKapasitesi!.isNotEmpty) whereMap['yatak_kapasitesi'] = yatakKapasitesi;
        break;
      case 'tir':
        if (tirTipi != null && tirTipi!.isNotEmpty) whereMap['tir_tipi'] = tirTipi;
        if (tirMarka != null && tirMarka!.isNotEmpty) whereMap['marka_name'] = tirMarka;
        if (dingil != null && dingil!.isNotEmpty) whereMap['dingil'] = dingil;
        break;
    }
    
    // Backend formatı: { "where": {...}, "limit": 25 }
    final result = <String, dynamic>{};
    if (whereMap.isNotEmpty) {
      result['where'] = whereMap;
    }
    result['limit'] = pageSize;
    
    return result;
  }

  FilterParams copyWith({
    String? ilanTipi,
    String? odaSayisi,
    String? isitma,
    String? kullanimDurumu,
    String? imarDurumu,
    String? tapuDurumu,
    String? emlakTipi,
    String? turistikTipi,
    String? yildizSayisi,
    String? konumTipi,
    String? sezon,
    String? hafta,
    String? bolge,
    String? vites,
    String? yakitTipi,
    String? kasaTipi,
    String? motorTipi,
    String? motorHacmi,
    String? motorMarka,
    String? karavanTipi,
    String? karavanMarka,
    String? yatakKapasitesi,
    String? tirTipi,
    String? tirMarka,
    String? dingil,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? pageSize,
  }) {
    return FilterParams(
      ilanTipi: ilanTipi ?? this.ilanTipi,
      odaSayisi: odaSayisi ?? this.odaSayisi,
      isitma: isitma ?? this.isitma,
      kullanimDurumu: kullanimDurumu ?? this.kullanimDurumu,
      imarDurumu: imarDurumu ?? this.imarDurumu,
      tapuDurumu: tapuDurumu ?? this.tapuDurumu,
      emlakTipi: emlakTipi ?? this.emlakTipi,
      turistikTipi: turistikTipi ?? this.turistikTipi,
      yildizSayisi: yildizSayisi ?? this.yildizSayisi,
      konumTipi: konumTipi ?? this.konumTipi,
      sezon: sezon ?? this.sezon,
      hafta: hafta ?? this.hafta,
      bolge: bolge ?? this.bolge,
      vites: vites ?? this.vites,
      yakitTipi: yakitTipi ?? this.yakitTipi,
      kasaTipi: kasaTipi ?? this.kasaTipi,
      motorTipi: motorTipi ?? this.motorTipi,
      motorHacmi: motorHacmi ?? this.motorHacmi,
      motorMarka: motorMarka ?? this.motorMarka,
      karavanTipi: karavanTipi ?? this.karavanTipi,
      karavanMarka: karavanMarka ?? this.karavanMarka,
      yatakKapasitesi: yatakKapasitesi ?? this.yatakKapasitesi,
      tirTipi: tirTipi ?? this.tirTipi,
      tirMarka: tirMarka ?? this.tirMarka,
      dingil: dingil ?? this.dingil,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  /// Filtreleri sıfırla
  FilterParams reset() {
    return const FilterParams();
  }
  
  /// Aktif filtre sayısı
  int activeCount(String? subCategory) {
    int count = 0;
    if (ilanTipi != null && ilanTipi!.isNotEmpty) count++;
    
    switch (subCategory) {
      case 'konut':
        if (odaSayisi != null && odaSayisi!.isNotEmpty) count++;
        if (isitma != null && isitma!.isNotEmpty) count++;
        if (kullanimDurumu != null && kullanimDurumu!.isNotEmpty) count++;
        break;
      case 'arsa':
        if (imarDurumu != null && imarDurumu!.isNotEmpty) count++;
        if (tapuDurumu != null && tapuDurumu!.isNotEmpty) count++;
        if (emlakTipi != null && emlakTipi!.isNotEmpty) count++;
        break;
      case 'turistik':
        if (turistikTipi != null && turistikTipi!.isNotEmpty) count++;
        if (yildizSayisi != null && yildizSayisi!.isNotEmpty) count++;
        if (konumTipi != null && konumTipi!.isNotEmpty) count++;
        break;
      case 'devremulk':
        if (sezon != null && sezon!.isNotEmpty) count++;
        if (hafta != null && hafta!.isNotEmpty) count++;
        if (bolge != null && bolge!.isNotEmpty) count++;
        break;
      case 'otomobil':
        if (vites != null && vites!.isNotEmpty) count++;
        if (yakitTipi != null && yakitTipi!.isNotEmpty) count++;
        if (kasaTipi != null && kasaTipi!.isNotEmpty) count++;
        break;
      case 'motosiklet':
        if (motorTipi != null && motorTipi!.isNotEmpty) count++;
        if (motorHacmi != null && motorHacmi!.isNotEmpty) count++;
        if (motorMarka != null && motorMarka!.isNotEmpty) count++;
        break;
      case 'karavan':
        if (karavanTipi != null && karavanTipi!.isNotEmpty) count++;
        if (karavanMarka != null && karavanMarka!.isNotEmpty) count++;
        if (yatakKapasitesi != null && yatakKapasitesi!.isNotEmpty) count++;
        break;
      case 'tir':
        if (tirTipi != null && tirTipi!.isNotEmpty) count++;
        if (tirMarka != null && tirMarka!.isNotEmpty) count++;
        if (dingil != null && dingil!.isNotEmpty) count++;
        break;
    }
    
    return count;
  }
}

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

  /// Konut ilanı oluştur
  Future<bool> createKonut(Map<String, dynamic> payload) async {
    final response = await _api.post(ApiConfig.konutAdd, payload);
    return response.success;
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
  // FİLTRELEME VE PAGİNATİON
  // ═══════════════════════════════════════════════════════════════════════════

  /// Filtreleme ile ilanları getir (POST)
  Future<ListingResponse> getFilteredListings({
    required String subCategory,
    FilterParams? filters,
  }) async {
    final params = filters ?? const FilterParams();
    final endpoint = _getEndpointForSubCategory(subCategory);
    
    // Backend'in beklediği formatta gönder
    final backendData = params.toBackendMap(subCategory);
    
    final response = await _api.post(endpoint, backendData);
    
    if (response.success && response.data is List) {
      final listings = _isVehicleCategory(subCategory)
          ? _parseVehicleListings(response.data, subCategory)
          : _parsePropertyListings(response.data, subCategory);
      
      // Sıralama uygula (client-side)
      final sortedListings = _applySorting(listings, params);
      
      // Client-side pagination
      final totalCount = sortedListings.length;
      final pageSize = params.pageSize;
      final currentPage = params.page;
      final totalPages = (totalCount / pageSize).ceil();
      
      final startIndex = (currentPage - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      final paginatedListings = sortedListings.sublist(
        startIndex.clamp(0, totalCount),
        endIndex.clamp(0, totalCount),
      );
      
      return ListingResponse(
        listings: paginatedListings,
        totalCount: totalCount,
        currentPage: currentPage,
        totalPages: totalPages > 0 ? totalPages : 1,
        pageSize: pageSize,
      );
    }
    
    return ListingResponse(
      listings: [],
      totalCount: 0,
      currentPage: 1,
      totalPages: 1,
      pageSize: params.pageSize,
    );
  }

  /// Kategoriye göre filtreleme ile ilanları getir
  Future<ListingResponse> getFilteredListingsByCategory({
    required String category,
    FilterParams? filters,
  }) async {
    final params = filters ?? const FilterParams();
    
    List<Listing> allListings = [];
    
    if (category == 'emlak') {
      final results = await Future.wait([
        _getFilteredSubCategory('konut', params),
        _getFilteredSubCategory('arsa', params),
        _getFilteredSubCategory('turistik', params),
        _getFilteredSubCategory('devremulk', params),
      ]);
      allListings = results.expand((list) => list).toList();
    } else if (category == 'vasita') {
      final results = await Future.wait([
        _getFilteredSubCategory('otomobil', params),
        _getFilteredSubCategory('motosiklet', params),
        _getFilteredSubCategory('karavan', params),
        _getFilteredSubCategory('tir', params),
      ]);
      allListings = results.expand((list) => list).toList();
    } else {
      // Tüm ilanlar
      final results = await Future.wait([
        _getFilteredSubCategory('konut', params),
        _getFilteredSubCategory('arsa', params),
        _getFilteredSubCategory('turistik', params),
        _getFilteredSubCategory('devremulk', params),
        _getFilteredSubCategory('otomobil', params),
        _getFilteredSubCategory('motosiklet', params),
        _getFilteredSubCategory('karavan', params),
        _getFilteredSubCategory('tir', params),
      ]);
      allListings = results.expand((list) => list).toList();
    }
    
    // Sıralama uygula
    allListings = _applySorting(allListings, params);
    
    // Pagination
    final totalCount = allListings.length;
    final pageSize = params.pageSize;
    final currentPage = params.page;
    final totalPages = (totalCount / pageSize).ceil();
    
    final startIndex = (currentPage - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final paginatedListings = allListings.sublist(
      startIndex.clamp(0, totalCount),
      endIndex.clamp(0, totalCount),
    );
    
    return ListingResponse(
      listings: paginatedListings,
      totalCount: totalCount,
      currentPage: currentPage,
      totalPages: totalPages > 0 ? totalPages : 1,
      pageSize: pageSize,
    );
  }

  Future<List<Listing>> _getFilteredSubCategory(String subCategory, FilterParams params) async {
    final endpoint = _getEndpointForSubCategory(subCategory);
    final backendData = params.toBackendMap(subCategory);
    final response = await _api.post(endpoint, backendData);
    
    if (response.success && response.data is List) {
      return _isVehicleCategory(subCategory)
          ? _parseVehicleListings(response.data, subCategory)
          : _parsePropertyListings(response.data, subCategory);
    }
    return [];
  }

  String _getEndpointForSubCategory(String subCategory) {
    switch (subCategory) {
      case 'otomobil':
        return ApiConfig.otomobilGet;
      case 'motosiklet':
        return ApiConfig.motosikletGet;
      case 'karavan':
        return ApiConfig.karavanGet;
      case 'tir':
        return ApiConfig.tirGet;
      case 'konut':
        return ApiConfig.konutGet;
      case 'arsa':
        return ApiConfig.arsaGet;
      case 'turistik':
        return ApiConfig.turistikGet;
      case 'devremulk':
        return ApiConfig.devreGet;
      default:
        return ApiConfig.otomobilGet;
    }
  }

  bool _isVehicleCategory(String subCategory) {
    return ['otomobil', 'motosiklet', 'karavan', 'tir'].contains(subCategory);
  }

  List<Listing> _applySorting(List<Listing> listings, FilterParams params) {
    if (params.sortBy == null) return listings;
    
    final sorted = List<Listing>.from(listings);
    
    switch (params.sortBy) {
      case 'fiyat':
        sorted.sort((a, b) => params.sortOrder == 'desc'
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price));
        break;
      case 'tarih':
        sorted.sort((a, b) => params.sortOrder == 'desc'
            ? b.createdAt.compareTo(a.createdAt)
            : a.createdAt.compareTo(b.createdAt));
        break;
    }
    
    return sorted;
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

