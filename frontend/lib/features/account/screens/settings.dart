import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFA5D6A7), // açık yeşil
      child: Center(
        child: Text(
          'SETTINGS PAGE',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
