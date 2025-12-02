import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/// Kullanıcı modeli
class User {
  final int kullaniciId;
  final int? adresId;
  final String email;
  final String ad;
  final String soyad;
  final String telefonNo;
  final String kullaniciTipi;

  User({
    required this.kullaniciId,
    this.adresId,
    required this.email,
    required this.ad,
    required this.soyad,
    required this.telefonNo,
    required this.kullaniciTipi,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      kullaniciId: json['kullanici_id'] ?? 0,
      adresId: json['adres_id'],
      email: json['email'] ?? '',
      ad: json['ad'] ?? '',
      soyad: json['soyad'] ?? '',
      telefonNo: json['telefon_no'] ?? '',
      kullaniciTipi: json['kullanici_tipi'] ?? 'bireysel',
    );
  }

  String get fullName => '$ad $soyad';
}

/// Auth Response
class AuthResponse {
  final bool success;
  final String? message;
  final User? user;
  final int? userId;

  AuthResponse({
    required this.success,
    this.message,
    this.user,
    this.userId,
  });
}

/// Auth Service - Kullanıcı kimlik doğrulama işlemlerini yönetir
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Mevcut oturum açmış kullanıcı
  User? _currentUser;
  final ValueNotifier<User?> _userNotifier = ValueNotifier<User?>(null);

  User? get currentUser => _currentUser;
  ValueListenable<User?> get userListenable => _userNotifier;
  bool get isLoggedIn => _currentUser != null;

  void _setCurrentUser(User? user) {
    _currentUser = user;
    _userNotifier.value = user;
  }

  /// Giriş yap
  Future<AuthResponse> login(String email, String sifre) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.login}');
      final response = await http.post(
        uri,
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'sifre': sifre,
        }),
      );

      debugPrint('🔐 Login Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        // Backend kullanici_id döndürüyor
        final userId = int.tryParse(response.body);
        
        if (userId != null) {
          // Kullanıcı bilgilerini doğrudan ID ile al (session'a bağlı değil)
          final user = await fetchUserById(userId);

          return AuthResponse(
            success: true,
            message: 'Giriş başarılı',
            userId: userId,
            user: user,
          );
        }
      }

      return AuthResponse(
        success: false,
        message: response.body.isNotEmpty ? response.body : 'Giriş başarısız',
      );
    } catch (e) {
      debugPrint('❌ Login Hatası: $e');
      return AuthResponse(
        success: false,
        message: 'Bağlantı hatası: $e',
      );
    }
  }

  /// Kayıt ol
  Future<AuthResponse> signup({
    required String ad,
    required String soyad,
    required String email,
    required String telefonNo,
    required String sifre,
    String kullaniciTipi = 'bireysel',
    int? adresId,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.signup}');
      final response = await http.post(
        uri,
        headers: _headers,
        body: jsonEncode({
          'ad': ad,
          'soyad': soyad,
          'email': email,
          'telefon_no': telefonNo,
          'sifre': sifre,
          'kullanici_tipi': kullaniciTipi,
          'adres_id': adresId,
          'olusturulma_tarihi': now,
          'guncellenme_tarihi': now,
        }),
      );

      debugPrint('📝 Signup Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        return AuthResponse(
          success: true,
          message: 'Kayıt başarılı! Giriş yapabilirsiniz.',
        );
      }

      return AuthResponse(
        success: false,
        message: response.body.isNotEmpty ? response.body : 'Kayıt başarısız',
      );
    } catch (e) {
      debugPrint('❌ Signup Hatası: $e');
      return AuthResponse(
        success: false,
        message: 'Bağlantı hatası: $e',
      );
    }
  }

  /// Çıkış yap
  Future<void> logout() async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.logout}');
      await http.get(uri, headers: _headers);
      _setCurrentUser(null);
      debugPrint('👋 Logout başarılı');
    } catch (e) {
      debugPrint('❌ Logout Hatası: $e');
      _setCurrentUser(null);
    }
  }

  /// Belirli bir ID'ye göre kullanıcı bilgilerini getir (/user/get)
  Future<User?> fetchUserById(int userId) async {
    try {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}${ApiConfig.userGet}?kullanici_id=$userId',
      );

      final response = await http.get(uri, headers: _headers);
      debugPrint('👤 FetchUserById Response: \'${response.statusCode}\' - ${response.body}');

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          final user = User.fromJson(data);
          _setCurrentUser(user);
          return user;
        }
      }
    } catch (e) {
      debugPrint('❌ FetchUserById Hatası: $e');
    }
    return null;
  }

  /// Mevcut kullanıcı bilgilerini getir
  Future<User?> _fetchCurrentUser() async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.currentUser}');
      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200 && response.body != 'User bulunamadı') {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          final user = User.fromJson(data);
          _setCurrentUser(user);
          return user;
        }
      }
    } catch (e) {
      debugPrint('❌ Fetch User Hatası: $e');
    }
    return null;
  }

  /// Kullanıcıyı local olarak set et (login sonrası)
  void setUser(User user) {
    _setCurrentUser(user);
  }

  /// Kullanıcıyı temizle
  void clearUser() {
    _setCurrentUser(null);
  }
}

