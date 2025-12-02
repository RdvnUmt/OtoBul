import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'shared/app_header.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initializeDateFormatting('tr_TR', null);
  runApp(const OtoBulApp());
}

class OtoBulApp extends StatelessWidget {
  const OtoBulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) {
        final auth = AuthService();

        return ValueListenableBuilder<User?>(
          valueListenable: auth.userListenable,
          builder: (context, user, _) {
            final isLoggedIn = user != null;

            return Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: AppHeader(
                    onLogoTap: () => appRouter.go(AppRoutes.home),
                    onLoginTap:
                        isLoggedIn ? null : () => appRouter.go(AppRoutes.login),
                    onRegisterTap: isLoggedIn
                        ? null
                        : () => appRouter.go(AppRoutes.register),
                    onProfileTap: isLoggedIn
                        ? () => appRouter.go(AppRoutes.profile)
                        : null,
                    onPostAdTap: isLoggedIn
                        ? () => appRouter.go(AppRoutes.listingCreate)
                        : null,
                    showLogin: !isLoggedIn,
                    showRegister: !isLoggedIn,
                    showProfile: isLoggedIn,
                    showPostAd: isLoggedIn,
                  ),
                ),
                Expanded(
                  child: child ?? const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
