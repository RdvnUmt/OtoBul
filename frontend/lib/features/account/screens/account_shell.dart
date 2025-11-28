import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_header.dart';
import '../../../shared/app_footer.dart';
import '../../../app/app_router.dart';
import '../widgets/sidebar.dart';

ProfileSection sectionFromLocation(String path) {
  if (path.startsWith(AppRoutes.listings)) return ProfileSection.listings;
  if (path.startsWith(AppRoutes.favorites)) return ProfileSection.favorites;
  if (path.startsWith(AppRoutes.settings)) return ProfileSection.settings;
  return ProfileSection.profile;
}

String routeForSection(ProfileSection s) {
  switch (s) {
    case ProfileSection.profile:
      return AppRoutes.profile;
    case ProfileSection.listings:
      return AppRoutes.listings;
    case ProfileSection.favorites:
      return AppRoutes.favorites;
    case ProfileSection.settings:
      return AppRoutes.settings;
  }
}

/// ✅ Sağ içerik alanı: tek scroll + en altta footer
class AccountRightPane extends StatelessWidget {
  const AccountRightPane({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: child),

          // İçerik kısa olsa bile footer sağ panelin en altına iner.
          // İçerik uzunsa footer en sonda görünür.
          SliverFillRemaining(
            hasScrollBody: false,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: AppFooter(),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountShell extends StatelessWidget {
  const AccountShell({
    super.key,
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;
    final selected = sectionFromLocation(location);

    void onSelect(ProfileSection section) {
      if (section == selected) return; // ✅ string kıyası değil, section kıyası
      context.go(routeForSection(section));
    }

    return Scaffold(
      appBar: AppHeader(
        onLogoTap: () {},
        onLoginTap: () {},
        onRegisterTap: () {},
      ),
      drawer: isWide
          ? null
          : Drawer(
              child: SidebarAccount(
                isDrawer: true,
                selected: selected,
                onSelected: onSelect,
                onLogout: () {
                  // logout
                },
              ),
            ),
      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 280,
              child: SidebarAccount(
                selected: selected,
                onSelected: onSelect,
                onLogout: () {
                  // logout
                },
              ),
            ),

          // ✅ Footer sadece sağ panelin altında ve tüm sağ taraf scrollable
          Expanded(
            child: AccountRightPane(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
