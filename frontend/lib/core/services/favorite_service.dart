import '../config/api_config.dart';
import '../models/listing_model.dart';
import 'api_service.dart';
import 'listing_service.dart';

/// Favori servisleri - Favori ekleme, silme ve listeleme
class FavoriteService {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  final ApiService _api = ApiService();
  final ListingService _listingService = ListingService();

  /// İlanı favorilere ekle
  Future<bool> addFavorite({
    required int ilanId,
    required int kullaniciId,
  }) async {
    final body = <String, dynamic>{
      'ilan_id': ilanId,
      'kullanici_id': kullaniciId,
      'olusturulma_tarihi': DateTime.now().toIso8601String(),
    };

    final response = await _api.post(ApiConfig.favoriAdd, body);
    return response.success;
  }

  /// Favoriden kaldır
  Future<bool> removeFavorite({
    required int ilanId,
    required int kullaniciId,
  }) async {
    final body = <String, dynamic>{
      'ilan_id': ilanId,
      'kullanici_id': kullaniciId,
    };

    final response = await _api.delete(ApiConfig.favoriDelete, body);
    return response.success;
  }

  /// Kullanıcının favori ilan id'lerini getir
  Future<List<int>> getFavoriteListingIds({
    required int kullaniciId,
  }) async {
    final response = await _api.get('${ApiConfig.favoriGet}?kullanici_id=$kullaniciId');
    if (!response.success || response.data == null) return [];

    final data = response.data;
    if (data is List) {
      return data
          .map((e) {
            if (e is Map<String, dynamic> || e is Map) {
              final map = e as Map;
              final ilan = map['ilan_id'];
              if (ilan is int) return ilan;
              if (ilan is String) return int.tryParse(ilan) ?? -1;
            }
            return -1;
          })
          .where((id) => id > 0)
          .toList();
    }

    return [];
  }

  /// Kullanıcının favori ilanlarını Listing listesi olarak getir
  Future<List<Listing>> getFavoriteListingsForUser(int kullaniciId) async {
    final ids = await getFavoriteListingIds(kullaniciId: kullaniciId);
    if (ids.isEmpty) return [];

    final allListings = await _listingService.getAllListings();
    final idSet = ids.map((e) => e.toString()).toSet();

    return allListings
        .where((listing) => idSet.contains(listing.id.toString()))
        .map((l) => l.copyWith(isFavorite: true))
        .toList();
  }
}
