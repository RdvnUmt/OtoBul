import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/account/screens/account_shell.dart';

// Sayfaların:
import '../features/account/screens/profile.dart';
import '../features/account/screens/my_listings.dart';
import '../features/account/screens/favorite_listings.dart';
import '../features/account/screens/settings.dart';

class AppRoutes {
  static const String account = '/hesabim';

  static const String profile = '$account/profilim';
  static const String listings = '$account/ilanlarim';
  static const String favorites = '$account/favori-ilanlarim';
  static const String settings = '$account/ayarlar';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.profile,
  routes: [
    // ✅ /hesabim yazılırsa boş kalmasın
    GoRoute(
      path: AppRoutes.account,
      redirect: (_, __) => AppRoutes.profile,
    ),

    ShellRoute(
      builder: (context, state, child) {
        return AccountShell(
          location: state.uri.path,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage()),
        ),
        GoRoute(
          path: AppRoutes.listings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MyListingsPage()),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoriteListingsPage()),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    ),
  ],
);
