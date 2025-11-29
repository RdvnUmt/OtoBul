import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'shared/app_header.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
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
                onLoginTap: () => appRouter.go(AppRoutes.auth),
                onRegisterTap: () => appRouter.go(AppRoutes.auth),
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
