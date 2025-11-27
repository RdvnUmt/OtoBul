import 'package:flutter/material.dart';

class FavoriteListingsPage extends StatelessWidget {
  const FavoriteListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFF48FB1), // pembe
      child: Center(
        child: Text(
          'FAVORITE LISTINGS PAGE',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
