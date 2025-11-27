import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/app_header.dart';
import '../widgets/sidebar.dart'; // HomeScreenSidebar + ProfileSection burada tanımlı
import '../../../app/app_router.dart';

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
    // ignore: no_default_cases
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
      final target = routeForSection(section);
      if (target != location) context.go(target);
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
              child: HomeScreenSidebar(
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
              child: HomeScreenSidebar(
                selected: selected,
                onSelected: onSelect,
                onLogout: () {
                  // logout
                },
              ),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
