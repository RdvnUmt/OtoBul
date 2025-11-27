import 'package:flutter/material.dart';

class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF90CAF9), // açık mavi
      child: Center(
        child: Text(
          'MY LISTINGS PAGE',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
