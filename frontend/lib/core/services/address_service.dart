import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/address_model.dart';

/// Adres Servisi - Adres CRUD işlemlerini yönetir
class AddressService {
  static final AddressService _instance = AddressService._internal();
  factory AddressService() => _instance;
  AddressService._internal();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Adres ID'ye göre adres bilgilerini getir
  Future<Address?> getAddressById(int adresId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.adresGet}?adres_id=$adresId',
      );

      final response = await http.get(uri, headers: _headers);
      debugPrint('🏠 GetAddress Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          return Address.fromJson(data);
        }
      }
    } catch (e) {
      debugPrint('❌ GetAddress Hatası: $e');
    }
    return null;
  }

  /// Yeni adres ekle
  /// Backend'den yeni oluşturulan adres_id döner
  Future<int?> addAddress(Address address) async {
    try {
      final now = DateTime.now().toIso8601String();
      final body = address.toJson();
      body['olusturulma_tarihi'] = now;
      body['guncellenme_tarihi'] = now;

      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.adresAdd}');
      final response = await http.post(
        uri,
        headers: _headers,
        body: jsonEncode(body),
      );

      debugPrint('🏠 AddAddress Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        // Backend "123" şeklinde string olarak adres_id dönüyor
        final adresId = int.tryParse(response.body);
        return adresId;
      }
    } catch (e) {
      debugPrint('❌ AddAddress Hatası: $e');
    }
    return null;
  }

  /// Mevcut adresi güncelle
  Future<bool> updateAddress(Address address) async {
    if (address.adresId == null) return false;

    try {
      final now = DateTime.now().toIso8601String();
      final body = address.toJson();
      body['guncellenme_tarihi'] = now;

      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.adresUpdate}');
      final response = await http.put(
        uri,
        headers: _headers,
        body: jsonEncode(body),
      );

      debugPrint('🏠 UpdateAddress Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint('❌ UpdateAddress Hatası: $e');
    }
    return false;
  }

  /// Adresi sil
  Future<bool> deleteAddress(int adresId) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.adresDelete}');
      final request = http.Request('DELETE', uri);
      request.headers.addAll(_headers);
      request.body = jsonEncode({'adres_id': adresId});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('🏠 DeleteAddress Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint('❌ DeleteAddress Hatası: $e');
    }
    return false;
  }
}
