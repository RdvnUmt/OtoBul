import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/core/data/mock_listings.dart';
import 'package:my_flutter_app/core/models/listing_model.dart';
import '../core/services/auth_service.dart';

import '../features/account/screens/account_shell.dart';

// Screens
import '../features/home/screens/home_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/listing_create/screens/listing_create_screen.dart';
import '../features/listing_detail/screens/listing_detail_screen.dart';

import '../features/account/screens/profile.dart';
import '../features/account/screens/my_listings.dart';
import '../features/account/screens/favorite_listings.dart';
import '../features/account/screens/settings.dart';

class AppRoutes {
  // Ana sayfalar
  static const String home = '/';
  static const String listingDetail = '/ilan-detay/:id';

  // Emlak Kategorileri
  static const String property = '/emlak';
  static const String residential = '$property/konut';
  static const String land = '$property/arsa';
  static const String touristicFacility = '$property/turistik-tesis';
  static const String timeshare = '$property/devremulk';

  // Vasıta Kategorileri
  static const String vehicle = '/vasita';
  static const String car = '$vehicle/otomobil';
  static const String truck = '$vehicle/tir';
  static const String caravan = '$vehicle/karavan';
  static const String motorcycle = '$vehicle/motosiklet';

  static const String login = '/giris';
  static const String register = '/kayit';

  static const String listingCreate = '/ilan-ver';

  // Hesap sayfaları
  static const String account = '/hesabim';
  static const String profile = '$account/profilim';
  static const String listings = '$account/ilanlarim';
  static const String favorites = '$account/favori-ilanlarim';
  static const String settings = '$account/ayarlar';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Ana Sayfa
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),

    // İlan Detay
    GoRoute(
      path: '/ilan-detay/:id',
      pageBuilder: (context, state) {
        final listing = state.extra as Listing?;
        return NoTransitionPage(child: ListingDetailScreen(listing: listing));
      },
    ),

    // Giriş Yap
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginScreen()),
    ),

    // Hesap Oluştur
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: RegisterScreen()),
    ),

    // İlan Ver (Create + Edit)
    GoRoute(
      path: AppRoutes.listingCreate,
      pageBuilder: (context, state) => NoTransitionPage(
        child: ListingCreateScreen(initialExtra: state.extra), // ✅ extra geçir
      ),
    ),

    // /hesabim yazılırsa profile'a yönlendir
    GoRoute(path: AppRoutes.account, redirect: (_, __) => AppRoutes.profile),

    // Hesap Sayfaları (Shell Route)
    ShellRoute(
      builder: (context, state, child) {
        return AccountShell(location: state.uri.path, child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) {
            final auth = AuthService();
            final user = auth.currentUser;

            return NoTransitionPage(
              child: ProfilePage(
                initialFirstName: user?.ad ?? '',
                initialLastName: user?.soyad ?? '',
                phone: user?.telefonNo ?? '',
                email: user?.email ?? '',
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.listings,
          pageBuilder: (context, state) => NoTransitionPage(
            child: MyListingsPage(
              myListings: MockListings.allListings, // örnek
              onEditTap: (l) => context.push(AppRoutes.listingCreate, extra: l), // ✅
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          pageBuilder: (context, state) => NoTransitionPage(
            child: FavoriteListingsPage(favorites: MockListings.allListings),
          ),
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
