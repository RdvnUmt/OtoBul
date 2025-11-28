import 'package:flutter/material.dart';

class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: const ColoredBox(
        color: Color.fromARGB(255, 255, 255, 255), // açık mavi
        child: Center(
          child: Text(
            'MY LISTINGS PAGE',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
