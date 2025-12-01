import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
class AccountRightPane extends StatefulWidget {
  const AccountRightPane({super.key, required this.child});
  final Widget child;

  @override
  State<AccountRightPane> createState() => _AccountRightPaneState();
}

class _AccountRightPaneState extends State<AccountRightPane> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: true,   // ✅ sürekli görünsün istersen
        trackVisibility: true,   // ✅ track de görünsün istersen
        interactive: true,       // ✅ sürükleyerek scroll
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(child: widget.child),
            // Footer yoksa bunu da kaldırabilirsin; boş sliver’a gerek yok.
          ],
        ),
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
      if (section == selected) return;
      context.go(routeForSection(section));
    }

    return Scaffold(
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
