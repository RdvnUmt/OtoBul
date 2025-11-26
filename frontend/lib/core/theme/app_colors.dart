import 'package:flutter/material.dart';

/// Uygulamadaki renklerin tek kaynağı.
/// - Brand renkleri burada
/// - Material ColorScheme burada üretilir
/// - Ek semantic renkler (success/warning/info) burada
final class AppColors {
  AppColors._();

  // Brand (senin sitenin kurumsal renkleri)
  static const Color brandPrimary = Color(0xFF2D6CDF);
  static const Color brandSecondary = Color(0xFFFFB300);

  // Semantic colors (Material dışında sık kullanılanlar)
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color danger = Color(0xFFD32F2F);
  static const Color info = Color(0xFF0288D1);

  // Neutral helpers (özellikle border, divider için)
  static const Color borderLight = Color(0xFFE5E7EB); // very light gray
  static const Color borderDark = Color(0xFF2A2F3A);  // dark gray-ish
}
