import 'package:flutter/material.dart';

import '../../../shared/app_header.dart'; // path sende farklıysa düzelt
import '../widgets/sidebar.dart'; // aynı klasör değilse path düzelt

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ProfileSection _selected = ProfileSection.favorites;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      appBar: AppHeader(
        onLogoTap: () {
          // örn: Navigator.pushNamed(context, '/');
        },
        onLoginTap: () {
          // örn: Navigator.pushNamed(context, '/login');
        },
        onRegisterTap: () {
          // örn: Navigator.pushNamed(context, '/register');
        },
      ),

      // mobilde isWide değilken drawer gösteriyoruz
      drawer: isWide
          ? null
          : Drawer(
              child: HomeScreenSidebar(
                isDrawer: true,
                selected: _selected,
                onSelected: (section) => setState(() => _selected = section),
                onLogout: () {
                  // TODO: logout aksiyonu
                },
              ),
            ),

      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 280,
              child: HomeScreenSidebar(
                selected: _selected,
                onSelected: (section) => setState(() => _selected = section),
                onLogout: () {
                  // TODO: logout aksiyonu
                },
              ),
            ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: IndexedStack(
                index: _selected.index,
                children: const [
                  FavoritesPage(),
                  ListingsPage(),
                  MessagesPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sağ tarafta gösterilecek sayfalar (içerikleri sen dolduracaksın)
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

class ListingsPage extends StatelessWidget {
  const ListingsPage({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
