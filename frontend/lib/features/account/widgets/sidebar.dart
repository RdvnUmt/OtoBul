import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart'; // path sende farklıysa düzelt
import 'sidebar_buttons.dart';

/// Sayfada gerçekten gösterdiğin 3 section (IndexedStack ile uyumlu)
enum ProfileSection { profile, favorites, listings, settings }

class HomeScreenSidebar extends StatelessWidget {
  const HomeScreenSidebar({
    super.key,
    required this.selected,
    required this.onSelected,
    this.isDrawer = false,
    this.onLogout,
    this.onOtherTap,
  });

  final ProfileSection selected;
  final ValueChanged<ProfileSection> onSelected;

  /// Drawer içindeyken tıklayınca otomatik kapatmak için
  final bool isDrawer;

  final VoidCallback? onLogout;

  /// Henüz bağlamadığın menüler için (İstersen route vs. bağlarsın)
  final void Function(String key)? onOtherTap;

  @override
  Widget build(BuildContext context) {
    // ============================
    // SIDEBAR STİLİNİ BURADAN DEĞİŞTİR ✅
    // Arka planı özellikle buradan değiştirmen yeterli.
    // ============================
    final palette = SidebarPalette(
      background: AppColors.borderLight, // <- SIDEBAR ARKAPLANINI BURADAN DEĞİŞTİR
      divider: Colors.white.withOpacity(0.15),
      itemHover: Colors.white.withOpacity(0.06),
      itemSelected: Colors.white.withOpacity(0.08),
      indicator: AppColors.primaryLight_2,
      text: Colors.white.withOpacity(0.92),
      textSelected:  AppColors.primaryLight_2,
      icon: Colors.white.withOpacity(0.92),
      iconSelected: AppColors.primaryLight_2,
    );

    void closeIfDrawer() {
      if (isDrawer) Navigator.of(context).pop();
    }

    void select(ProfileSection section) {
      onSelected(section);
      closeIfDrawer();
    }

    return Material(
      color: palette.background,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Profil alanı yok (isteğin buydu). Sadece üst boşluk bıraktım.
            // İstersen buraya logo vs koyarsın.

            SidebarButton(
              palette: palette,
              icon: Icons.person_outline,
              label: 'Profil',
              selected: selected == ProfileSection.profile,
              onTap: () => select(ProfileSection.profile),
            ),

            SidebarButton(
              palette: palette,
              icon: Icons.format_list_bulleted,
              label: 'İlanlar',
              selected: selected == ProfileSection.listings,
              onTap: () => select(ProfileSection.listings),
            ),


            SidebarButton(
              palette: palette,
              icon: Icons.star_border,
              label: 'Favori İlanlar',
              selected: selected == ProfileSection.favorites,
              onTap: () => select(ProfileSection.favorites),
            ),

            SidebarButton(
              palette: palette,
              icon: Icons.settings_outlined,
              label: 'Ayarlar',
              selected: selected == ProfileSection.settings,
              onTap: () => select(ProfileSection.settings),
            ),

            const Spacer(),

            Divider(height: 1, thickness: 1, color: palette.divider),

            SidebarButton(
              palette: palette,
              icon: Icons.logout,
              label: 'Çıkış Yap',
              onTap: () {
                onLogout?.call();
                closeIfDrawer();
              },
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
