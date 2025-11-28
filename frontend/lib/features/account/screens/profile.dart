
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DummyPage(
      title: 'PROFILE PAGE',
      background: Color.fromARGB(255, 255, 255, 255), // sarı
    );
  }
}

class _DummyPage extends StatelessWidget {
  const _DummyPage({required this.title, required this.background});

  final String title;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
