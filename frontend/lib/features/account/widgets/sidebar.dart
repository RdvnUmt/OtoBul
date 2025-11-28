import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart'; // path sende farklıysa düzelt
import 'sidebar_buttons.dart';

/// Sayfada gerçekten gösterdiğin 3 section (IndexedStack ile uyumlu)
enum ProfileSection { profile, favorites, listings, settings }

class SidebarAccount extends StatelessWidget {
  const SidebarAccount({
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

  IconData _headerIcon(ProfileSection s) {
    switch (s) {
      case ProfileSection.profile:
        return Icons.person;
      case ProfileSection.listings:
        return Icons.format_list_bulleted;
      case ProfileSection.favorites:
        return Icons.star;
      case ProfileSection.settings:
        return Icons.settings;
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = SidebarPalette(
      background: AppColors.borderLight,
      divider: Colors.white.withOpacity(0.15),
      itemHover: Colors.white.withOpacity(0.06),
      itemSelected: Colors.white.withAlpha(40),
      indicator: const Color.fromARGB(255, 34, 141, 255),
      text: const Color.fromARGB(170, 255, 255, 255),
      textSelected: const Color.fromARGB(255, 255, 255, 255),
      icon: const Color.fromARGB(170, 255, 255, 255),
      iconSelected: const Color.fromARGB(255, 255, 255, 255),
    );

    void closeIfDrawer() {
      if (isDrawer) Navigator.of(context).pop();
    }

    void select(ProfileSection section) {
      if (isDrawer) Navigator.of(context).pop(); // ✅ önce drawer kapanır
      onSelected(section); // ✅ sonra route
    }

    return Material(
      color: palette.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            // Sidebar genişliğine neredeyse eşit; ama yükseklikte taşmayı engelle.
            final logoDim = math.min(w * 0.92, h * 0.22).clamp(48.0, w);
            final padding = (logoDim * 0.14).clamp(8.0, 24.0);

            return Column(
              children: [
                const SizedBox(height: 12),

                // ✅ Seçili menüye göre üstte dairesel logo (alanı doldurur)
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 10),
                  child: Center(
                    child: Container(
                      width: logoDim.toDouble(),
                      height: logoDim.toDouble(),
                      padding: EdgeInsets.all(padding.toDouble() * 0.6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryLight_2,
                            AppColors.primaryLight,
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: palette.divider, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),

                        // ✅ AnimatedSwitcher child'ı 24px'e sıkıştırmasın
                        layoutBuilder: (currentChild, previousChildren) =>
                            Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            ),

                        child: FittedBox(
                          key: ValueKey(selected),
                          fit: BoxFit.contain,
                          child: Icon(
                            _headerIcon(selected),
                            color: const Color.fromARGB(255, 178, 219, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

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
            );
          },
        ),
      ),
    );
  }
}
