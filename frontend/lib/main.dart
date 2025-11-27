import 'package:flutter/material.dart';
import '/core/theme/theme.dart';
import '/features/home/screens/home_screen.dart';

void main() {
  runApp(const OtoBulApp());
}

class OtoBulApp extends StatelessWidget {
  const OtoBulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OtoBul',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // Zorunlu karanlık mod
      darkTheme: buildCorporateTheme(),
      home: const HomeScreen(),
    );
  }
}