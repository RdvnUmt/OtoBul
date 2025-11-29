import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/account/screens/account_shell.dart';

// Screens
import '../features/home/screens/home_screen.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/listing_create/screens/listing_create_screen.dart';

import '../features/account/screens/profile.dart';
import '../features/account/screens/my_listings.dart';
import '../features/account/screens/favorite_listings.dart';
import '../features/account/screens/settings.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/giris';
  static const String listingCreate = '/ilan-ver';

  static const String account = '/hesabim';
  static const String profile = '$account/profilim';
  static const String listings = '$account/ilanlarim';
  static const String favorites = '$account/favori-ilanlarim';
  static const String settings = '$account/ayarlar';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.auth,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: AuthScreen()),
    ),
    GoRoute(
      path: AppRoutes.listingCreate,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ListingCreateScreen()),
    ),

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
