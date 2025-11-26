import 'package:flutter/material.dart';

/// Typo standardı:
/// - Font family tek yerden yönetilir
/// - TextTheme tek fonksiyondan üretilir
final class AppTypography {
  AppTypography._();

  /// Font eklemediysen "Roboto" kullan.
  static const String fontFamily = 'Inter';

  /// Material 3 taban typograph’ı alıp kendi ölçülerimizle stabilize ediyoruz.
  static TextTheme textTheme(Brightness brightness) {
    final base = (brightness == Brightness.dark)
        ? Typography.material2021().white
        : Typography.material2021().black;

    // Bazı sık kullanılan size/weight değerlerini sabitleyelim.
    // İstersen bunları projenin tasarımına göre sonra revize edersin.
    final tuned = base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.w700),
      displayMedium: base.displayMedium?.copyWith(fontSize: 40, fontWeight: FontWeight.w700),
      displaySmall: base.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.w700),

      headlineLarge: base.headlineLarge?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: base.headlineMedium?.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
      headlineSmall: base.headlineSmall?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),

      titleLarge: base.titleLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: base.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: base.titleSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),

      bodyLarge: base.bodyLarge?.copyWith(fontSize: 16, height: 1.35),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, height: 1.35),
      bodySmall: base.bodySmall?.copyWith(fontSize: 12, height: 1.35),

      labelLarge: base.labelLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: base.labelMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall: base.labelSmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
    );

    return _applyFontFamily(tuned, fontFamily);
  }

  static TextTheme _applyFontFamily(TextTheme theme, String family) {
    TextStyle? ff(TextStyle? s) => s?.copyWith(fontFamily: family);

    return theme.copyWith(
      displayLarge: ff(theme.displayLarge),
      displayMedium: ff(theme.displayMedium),
      displaySmall: ff(theme.displaySmall),

      headlineLarge: ff(theme.headlineLarge),
      headlineMedium: ff(theme.headlineMedium),
      headlineSmall: ff(theme.headlineSmall),

      titleLarge: ff(theme.titleLarge),
      titleMedium: ff(theme.titleMedium),
      titleSmall: ff(theme.titleSmall),

      bodyLarge: ff(theme.bodyLarge),
      bodyMedium: ff(theme.bodyMedium),
      bodySmall: ff(theme.bodySmall),

      labelLarge: ff(theme.labelLarge),
      labelMedium: ff(theme.labelMedium),
      labelSmall: ff(theme.labelSmall),
    );
  }
}
