import 'package:flutter/material.dart';
import 'app/app_router.dart'; // sende appRouter burada

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OtoBulApp());
}

class OtoBulApp extends StatelessWidget {
  const OtoBulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
