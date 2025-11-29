import 'package:flutter/material.dart';

class ListingCreateScreen extends StatelessWidget {
  const ListingCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: const ColoredBox(
        color: Color.fromARGB(255, 255, 255, 255), // açık mavi
        child: Center(
          child: Text(
            'LISTING CREATE PAGE',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
