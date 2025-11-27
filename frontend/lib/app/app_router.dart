import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/account/screens/account_shell.dart';

// Senin var olduğunu varsaydığım sayfalar:
import '../features/account/screens/profile.dart';
import '../features/account/screens/my_listings.dart';
import '../features/account/screens/favorite_listings.dart';
import '../features/account/screens/settings.dart';

class AppRoutes {
  // Arabam benzeri:
  static const String cockpit = '/arabam-kokpit';

  static const String profile = '$cockpit/profilim';
  static const String listings = '$cockpit/ilanlarim';
  static const String favorites = '$cockpit/favori-ilanlarim';
  static const String settings = '$cockpit/ayarlar';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.profile,
  routes: [
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
