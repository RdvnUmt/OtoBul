import '../models/listing_model.dart';

/// Mock İlan Verileri - Her kategori için 2 ilan
class MockListings {
  // ═══════════════════════════════════════════════════════════════════════════
  // KONUT İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> konutListings = [
    Listing(
      id: 'konut-1',
      title: '3+1 Lüks Daire Deniz Manzaralı',
      description: 'Kadıköy Moda\'da deniz manzaralı, yeni yapılmış rezidans dairesi',
      price: 4850000,
      location: 'Moda Mahallesi',
      city: 'İstanbul',
      district: 'Kadıköy',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400',
      category: 'emlak',
      subCategory: 'konut',
      sellerType: 'Sahibinden',
      details: const PropertyDetails(
        grossM2: 145,
        netM2: 130,
        roomCount: '3+1',
        buildingAge: 2,
        floor: 8,
        totalFloors: 12,
        heating: 'Merkezi',
        hasParking: true,
        hasElevator: true,
        isFurnished: false,
        deedStatus: 'Kat Mülkiyetli',
      ).toMap(),
    ),
    Listing(
      id: 'konut-2',
      title: '2+1 Yatırımlık Daire Metro Yakını',
      description: 'Esenyurt\'ta metro hattına yakın, kiracılı yatırımlık daire',
      price: 1650000,
      location: 'Fatih Mahallesi',
      city: 'İstanbul',
      district: 'Esenyurt',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400',
      category: 'emlak',
      subCategory: 'konut',
      sellerType: 'Emlak Ofisinden',
      details: const PropertyDetails(
        grossM2: 95,
        netM2: 85,
        roomCount: '2+1',
        buildingAge: 5,
        floor: 4,
        totalFloors: 8,
        heating: 'Doğalgaz Kombi',
        hasParking: false,
        hasElevator: true,
        isFurnished: true,
        deedStatus: 'Kat Mülkiyetli',
      ).toMap(),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // ARSA İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> arsaListings = [
    Listing(
      id: 'arsa-1',
      title: 'İmarlı Villa Arsası 500 m²',
      description: 'Bodrum Yalıkavak\'ta denize 500m mesafede imarlı arsa',
      price: 8500000,
      location: 'Yalıkavak',
      city: 'Muğla',
      district: 'Bodrum',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400',
      category: 'emlak',
      subCategory: 'arsa',
      sellerType: 'Sahibinden',
      details: {
        'area': 500,
        'zoningStatus': 'Konut İmarlı',
        'parcelNo': '124',
        'blockNo': '45',
        'floorAreaRatio': '0.30',
      },
    ),
    Listing(
      id: 'arsa-2',
      title: 'Yatırımlık Tarla 2.500 m²',
      description: 'Çatalca\'da yola cepheli, elektriği olan tarla',
      price: 1250000,
      location: 'Merkez',
      city: 'İstanbul',
      district: 'Çatalca',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      imageUrl: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=400',
      category: 'emlak',
      subCategory: 'arsa',
      sellerType: 'Sahibinden',
      details: {
        'area': 2500,
        'zoningStatus': 'Tarla',
        'parcelNo': '89',
        'blockNo': '12',
        'floorAreaRatio': '-',
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // TURİSTİK TESİS İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> turistikListings = [
    Listing(
      id: 'turistik-1',
      title: '12 Odalı Butik Otel Satılık',
      description: 'Antalya Kaleiçi\'nde restore edilmiş tarihi butik otel',
      price: 28000000,
      location: 'Kaleiçi',
      city: 'Antalya',
      district: 'Muratpaşa',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
      category: 'emlak',
      subCategory: 'turistik',
      sellerType: 'Sahibinden',
      details: {
        'roomCount': 12,
        'bedCount': 24,
        'openArea': 200,
        'closedArea': 450,
        'hasPool': true,
        'starRating': 3,
      },
    ),
    Listing(
      id: 'turistik-2',
      title: 'Deniz Kenarı Pansiyon',
      description: 'Fethiye Ölüdeniz\'de 8 odalı denize sıfır pansiyon',
      price: 15500000,
      location: 'Ölüdeniz',
      city: 'Muğla',
      district: 'Fethiye',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      imageUrl: 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=400',
      category: 'emlak',
      subCategory: 'turistik',
      sellerType: 'Emlak Ofisinden',
      details: {
        'roomCount': 8,
        'bedCount': 16,
        'openArea': 150,
        'closedArea': 280,
        'hasPool': false,
        'starRating': 2,
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // DEVRE MÜLK İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> devremulkListings = [
    Listing(
      id: 'devremulk-1',
      title: 'Bodrum 2 Haftalık Devre Mülk',
      description: 'Bodrum Gümbet\'te 5 yıldızlı tesiste Temmuz dönemi',
      price: 185000,
      location: 'Gümbet',
      city: 'Muğla',
      district: 'Bodrum',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400',
      category: 'emlak',
      subCategory: 'devremulk',
      sellerType: 'Sahibinden',
      details: {
        'period': 'Temmuz 1-14',
        'roomCount': '1+1',
        'capacity': 4,
      },
    ),
    Listing(
      id: 'devremulk-2',
      title: 'Antalya 1 Haftalık Devre Mülk',
      description: 'Antalya Belek\'te golf tesisli otelde Ağustos dönemi',
      price: 120000,
      location: 'Belek',
      city: 'Antalya',
      district: 'Serik',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400',
      category: 'emlak',
      subCategory: 'devremulk',
      sellerType: 'Sahibinden',
      details: {
        'period': 'Ağustos 15-22',
        'roomCount': '2+1',
        'capacity': 6,
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // OTOMOBİL İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> otomobilListings = [
    Listing(
      id: 'otomobil-1',
      title: 'Hyundai i20 1.4 CRDi Elite',
      description: 'UZUN AUTODAN Hyundai i20 1.4 CRDi Elite 2016 Model Diyarbakır',
      price: 710000,
      location: 'Çınar',
      city: 'Diyarbakır',
      district: 'Çınar',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400',
      category: 'vasita',
      subCategory: 'otomobil',
      sellerType: 'Galeriden',
      details: const VehicleDetails(
        brand: 'Hyundai',
        model: 'i20',
        year: 2016,
        km: 138000,
        fuel: 'Dizel',
        gear: 'Düz',
        enginePower: 90,
        engineVolume: 1396,
        color: 'Beyaz',
        condition: 'İkinci El',
      ).toMap(),
    ),
    Listing(
      id: 'otomobil-2',
      title: 'BMW 3 Serisi 320i M Sport',
      description: 'Hatasız boyasız, tam dolu paket, sunroof, hafıza koltuk',
      price: 2350000,
      location: 'Levent',
      city: 'İstanbul',
      district: 'Beşiktaş',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400',
      category: 'vasita',
      subCategory: 'otomobil',
      sellerType: 'Sahibinden',
      details: const VehicleDetails(
        brand: 'BMW',
        model: '320i M Sport',
        year: 2021,
        km: 45000,
        fuel: 'Benzin',
        gear: 'Otomatik',
        enginePower: 170,
        engineVolume: 1998,
        color: 'Siyah',
        condition: 'İkinci El',
      ).toMap(),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // TIR İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> tirListings = [
    Listing(
      id: 'tir-1',
      title: 'Mercedes Actros 1841 Çekici',
      description: '2018 model, klimalı kabin, retarder, faal durumda',
      price: 3200000,
      location: 'Tuzla',
      city: 'İstanbul',
      district: 'Tuzla',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=400',
      category: 'vasita',
      subCategory: 'tir',
      sellerType: 'Sahibinden',
      details: {
        'brand': 'Mercedes',
        'model': 'Actros 1841',
        'year': 2018,
        'km': 420000,
        'fuel': 'Dizel',
        'gear': 'Otomatik',
        'cabinType': 'Yataklı',
        'tireCondition': 85,
        'hasTrailer': false,
      },
    ),
    Listing(
      id: 'tir-2',
      title: 'Volvo FH 500 Euro 6',
      description: 'Orijinal 380.000 km, servis bakımlı, takas olur',
      price: 4100000,
      location: 'Gebze',
      city: 'Kocaeli',
      district: 'Gebze',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      imageUrl: 'https://images.unsplash.com/photo-1586191582066-1c4e91c8abc4?w=400',
      category: 'vasita',
      subCategory: 'tir',
      sellerType: 'Galeriden',
      details: {
        'brand': 'Volvo',
        'model': 'FH 500',
        'year': 2019,
        'km': 380000,
        'fuel': 'Dizel',
        'gear': 'Otomatik',
        'cabinType': 'Yataklı',
        'tireCondition': 90,
        'hasTrailer': true,
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // KARAVAN İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> karavanListings = [
    Listing(
      id: 'karavan-1',
      title: 'Hobby De Luxe 495 UL Karavan',
      description: '2020 model, 4 kişilik, full donanım, sıfır gibi',
      price: 1850000,
      location: 'Nilüfer',
      city: 'Bursa',
      district: 'Nilüfer',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      imageUrl: 'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?w=400',
      category: 'vasita',
      subCategory: 'karavan',
      sellerType: 'Sahibinden',
      details: {
        'brand': 'Hobby',
        'model': 'De Luxe 495 UL',
        'year': 2020,
        'km': 12000,
        'bedCount': 4,
        'type': 'Çekme Karavan',
        'caravanType': 'Lüks',
      },
    ),
    Listing(
      id: 'karavan-2',
      title: 'Ford Transit Motokaravan',
      description: '2019, kendi yapım, güneş paneli, 220V inverter',
      price: 1450000,
      location: 'Çankaya',
      city: 'Ankara',
      district: 'Çankaya',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      imageUrl: 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=400',
      category: 'vasita',
      subCategory: 'karavan',
      sellerType: 'Sahibinden',
      details: {
        'brand': 'Ford',
        'model': 'Transit',
        'year': 2019,
        'km': 65000,
        'bedCount': 2,
        'type': 'Motokaravan',
        'caravanType': 'Panelvan Dönüşüm',
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // MOTOSİKLET İLANLARI
  // ═══════════════════════════════════════════════════════════════════════════
  static final List<Listing> motosikletListings = [
    Listing(
      id: 'moto-1',
      title: 'Honda CBR 650R ABS',
      description: '2022 model, 8.000 km, yeni lastik, bakımlı',
      price: 485000,
      location: 'Karşıyaka',
      city: 'İzmir',
      district: 'Karşıyaka',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400',
      category: 'vasita',
      subCategory: 'motosiklet',
      sellerType: 'Sahibinden',
      details: {
        'brand': 'Honda',
        'model': 'CBR 650R',
        'year': 2022,
        'km': 8000,
        'engineVolume': 649,
        'enginePower': 95,
        'cooling': 'Sıvı',
        'cylinderCount': 4,
      },
    ),
    Listing(
      id: 'moto-2',
      title: 'Yamaha MT-07 2021',
      description: 'Garaj arabası, hatasız, akrapovic egzoz',
      price: 395000,
      location: 'Osmangazi',
      city: 'Bursa',
      district: 'Osmangazi',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400',
      category: 'vasita',
      subCategory: 'motosiklet',
      sellerType: 'Galeriden',
      details: {
        'brand': 'Yamaha',
        'model': 'MT-07',
        'year': 2021,
        'km': 15000,
        'engineVolume': 689,
        'enginePower': 73,
        'cooling': 'Sıvı',
        'cylinderCount': 2,
      },
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // TÜM İLANLAR
  // ═══════════════════════════════════════════════════════════════════════════
  static List<Listing> get allListings => [
    ...konutListings,
    ...arsaListings,
    ...turistikListings,
    ...devremulkListings,
    ...otomobilListings,
    ...tirListings,
    ...karavanListings,
    ...motosikletListings,
  ];

  /// Kategoriye göre ilan getir
  static List<Listing> getByCategory(String category) {
    return allListings.where((l) => l.category == category).toList();
  }

  /// Alt kategoriye göre ilan getir
  static List<Listing> getBySubCategory(String subCategory) {
    return allListings.where((l) => l.subCategory == subCategory).toList();
  }

  /// Kategori ve alt kategoriye göre ilan getir
  static List<Listing> getListings({String? category, String? subCategory}) {
    if (subCategory != null) {
      return getBySubCategory(subCategory);
    } else if (category != null) {
      return getByCategory(category);
    }
    return allListings;
  }
}

