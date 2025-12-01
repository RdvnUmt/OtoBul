import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/// API Service - HTTP isteklerini yönetir
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// GET isteği - Standart HTTP GET (body gönderilmez)
  Future<ApiResponse> get(String endpoint) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final response = await http.get(uri, headers: _headers);
      
      debugPrint('✅ API GET: $endpoint -> ${response.statusCode}');
      return _handleResponse(response);
    } catch (e) {
      debugPrint('❌ API GET Hatası: $endpoint -> $e');
      return ApiResponse(success: false, message: 'Bağlantı hatası: $e');
    }
  }

  /// POST isteği
  Future<ApiResponse> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final response = await http.post(
        uri,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      return ApiResponse(success: false, message: 'Bağlantı hatası: $e');
    }
  }

  /// PUT isteği
  Future<ApiResponse> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final response = await http.put(
        uri,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      return ApiResponse(success: false, message: 'Bağlantı hatası: $e');
    }
  }

  /// DELETE isteği
  Future<ApiResponse> delete(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final request = http.Request('DELETE', uri);
      request.headers.addAll(_headers);
      request.body = jsonEncode(body);
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      return ApiResponse(success: false, message: 'Bağlantı hatası: $e');
    }
  }

  /// Response handler
  ApiResponse _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      dynamic data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {
        data = response.body;
      }
      return ApiResponse(
        success: true,
        data: data,
        statusCode: response.statusCode,
      );
    } else {
      return ApiResponse(
        success: false,
        message: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}

/// API Response modeli
class ApiResponse {
  final bool success;
  final dynamic data;
  final String? message;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });
}

