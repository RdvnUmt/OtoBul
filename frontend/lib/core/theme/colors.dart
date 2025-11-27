import 'package:flutter/material.dart';

class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // KURUMSAL RENK PALETİ - Profesyonel & Güven Veren
  // ═══════════════════════════════════════════════════════════════════════════

  // --- Zemin Renkleri (Derin Lacivert Tonları) ---
  static const Color background = Color(0xFF0A0E1A);      // Gece Laciverti
  static const Color surface = Color(0xFF111827);          // Kart/Panel arka planı
  static const Color surfaceLight = Color(0xFF1F2937);     // Hover durumu
  static const Color surfaceElevated = Color(0xFF374151);  // Yükseltilmiş yüzeyler

  // --- Marka Renkleri (Kurumsal & Sofistike) ---
  // Ana Renk: Kurumsal Mavi (Güven, Profesyonellik)
  static const Color primary = Color(0xFF2563EB);          // Royal Blue
  static const Color primaryLight = Color(0xFF3B82F6);     // Hover için
  static const Color primaryLight_2 = Color.fromARGB(255, 34, 201, 255);     // text için
  static const Color primaryDark = Color(0xFF1D4ED8);      // Tıklama anı
  
  // İkincil Renk: Platin/Gümüş (Lüks & Prestij)
  static const Color secondary = Color(0xFF94A3B8);        // Gümüş Gri
  static const Color secondaryLight = Color(0xFFCBD5E1);   // Açık Gümüş
  
  // Vurgu Rengi: Bakır/Bronz (Sıcaklık katmak için)
  static const Color accent = Color(0xFFD97706);           // Amber/Bronz
  static const Color accentLight = Color(0xFFFBBF24);      // Açık Amber

  // --- Anlamsal Renkler (Profesyonel Tonlar) ---
  static const Color success = Color(0xFF059669);          // Zümrüt Yeşili
  static const Color successLight = Color(0xFF10B981);
  static const Color error = Color(0xFFDC2626);            // Kırmızı
  static const Color errorLight = Color(0xFFF87171);
  static const Color warning = Color(0xFFD97706);          // Amber
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color info = Color(0xFF0284C7);             // Gökyüzü Mavisi
  static const Color infoLight = Color(0xFF38BDF8);

  // --- Metin Renkleri (Yüksek Okunabilirlik) ---
  static const Color textPrimary = Color(0xFFF9FAFB);      // Neredeyse Beyaz
  static const Color textSecondary = Color(0xFF9CA3AF);    // Orta Gri
  static const Color textTertiary = Color(0xFF6B7280);     // Koyu Gri
  static const Color textDisabled = Color(0xFF4B5563);     // Pasif Metin

  // --- Kenarlık ve Ayıraçlar ---
  static const Color border = Color(0xFF374151);           // Koyu Kenarlık
  static const Color borderLight = Color(0xFF4B5563);      // Orta Kenarlık
  static const Color divider = Color(0xFF1F2937);          // Ayıraç
}

class AppGradients {
  // ═══════════════════════════════════════════════════════════════════════════
  // KURUMSAL GRADYANLAR - İnce & Zarif
  // ═══════════════════════════════════════════════════════════════════════════

  // Ana Buton Gradyanı (Kurumsal Mavi)
  static const LinearGradient primary = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Premium Buton Gradyanı (Bronz/Altın - Özel Aksiyonlar için)
  static const LinearGradient premium = LinearGradient(
    colors: [Color(0xFFD97706), Color(0xFFB45309)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Yüzey Gradyanı (Hafif Derinlik Hissi)
  static const LinearGradient surface = LinearGradient(
    colors: [Color(0xFF111827), Color(0xFF0A0E1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Kart Hover Gradyanı
  static const LinearGradient cardHover = LinearGradient(
    colors: [Color(0xFF1F2937), Color(0xFF111827)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Görsel Overlay (Yazı okunabilirliği için)
  static const LinearGradient imageOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0xFF0A0E1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.4, 1.0],
  );

  // Header Gradyanı
  static const LinearGradient header = LinearGradient(
    colors: [Color(0xFF111827), Color(0xFF0F172A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
