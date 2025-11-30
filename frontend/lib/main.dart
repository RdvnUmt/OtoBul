import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'shared/app_header.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';

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
        return Column(
          children: [
            SafeArea(
              bottom: false,
              child: AppHeader(
                onLogoTap: () => appRouter.go(AppRoutes.home),
                onLoginTap: () => appRouter.go(AppRoutes.login),
                onRegisterTap: () => appRouter.go(AppRoutes.register),
                onProfileTap: () => appRouter.go(AppRoutes.profile),
                onPostAdTap: () => appRouter.go(AppRoutes.listingCreate),
              ),
            ),
            Expanded(
              child: child ?? const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}
