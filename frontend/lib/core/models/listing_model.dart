/// İlan Modeli - Tüm ilan tipleri için ortak yapı
class Listing {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String city;
  final String district;
  final DateTime createdAt;
  final String imageUrl;
  final String category; // emlak, vasita
  final String subCategory; // konut, arsa, otomobil, vb.
  final String sellerType; // Sahibinden, Galeriden
  final bool isFavorite;
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
    required this.imageUrl,
    required this.category,
    required this.subCategory,
    required this.sellerType,
    this.isFavorite = false,
    this.details = const {},
  });
}

/// Vasıta detayları
class VehicleDetails {
  final String brand;
  final String model;
  final int year;
  final int km;
  final String fuel; // Benzin, Dizel, Elektrik, Hibrit
  final String gear; // Manuel, Otomatik
  final int enginePower; // HP
  final int engineVolume; // cc
  final String color;
  final String condition; // İkinci El, Sıfır

  const VehicleDetails({
    required this.brand,
    required this.model,
    required this.year,
    required this.km,
    required this.fuel,
    required this.gear,
    required this.enginePower,
    required this.engineVolume,
    required this.color,
    required this.condition,
  });

  Map<String, dynamic> toMap() => {
    'brand': brand,
    'model': model,
    'year': year,
    'km': km,
    'fuel': fuel,
    'gear': gear,
    'enginePower': enginePower,
    'engineVolume': engineVolume,
    'color': color,
    'condition': condition,
  };
}

/// Emlak detayları
class PropertyDetails {
  final int grossM2;
  final int netM2;
  final String roomCount; // 2+1, 3+1, vb.
  final int buildingAge;
  final int floor;
  final int totalFloors;
  final String heating; // Doğalgaz, Kombi, vb.
  final bool hasParking;
  final bool hasElevator;
  final bool isFurnished;
  final String deedStatus; // Kat Mülkiyetli, vb.

  const PropertyDetails({
    required this.grossM2,
    required this.netM2,
    required this.roomCount,
    required this.buildingAge,
    required this.floor,
    required this.totalFloors,
    required this.heating,
    this.hasParking = false,
    this.hasElevator = false,
    this.isFurnished = false,
    required this.deedStatus,
  });

  Map<String, dynamic> toMap() => {
    'grossM2': grossM2,
    'netM2': netM2,
    'roomCount': roomCount,
    'buildingAge': buildingAge,
    'floor': floor,
    'totalFloors': totalFloors,
    'heating': heating,
    'hasParking': hasParking,
    'hasElevator': hasElevator,
    'isFurnished': isFurnished,
    'deedStatus': deedStatus,
  };
}

