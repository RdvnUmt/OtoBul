import 'package:flutter/material.dart';

import '../../../shared/app_header.dart'; // path sende farklıysa düzelt
import '../../../core/theme/colors.dart';   // path sende farklıysa düzelt

enum ProfileSection { favorites, listings, messages }

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
      drawer: isWide ? null : Drawer(child: _buildSidePanel(isDrawer: true)),

      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 280,
              child: _buildSidePanel(),
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

  Widget _buildSidePanel({bool isDrawer = false}) {
    return Container(
      color: AppColors.borderLight, // koyu gri gibi davranacak (palette göre)
      child: Column(
        children: [
          // Şimdilik sadece tıklanabilir alanlar; sen içerikleri dolduracaksın.
          _menuHitArea(ProfileSection.favorites, isDrawer: isDrawer),
          _menuHitArea(ProfileSection.listings, isDrawer: isDrawer),
          _menuHitArea(ProfileSection.messages, isDrawer: isDrawer),

          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _menuHitArea(ProfileSection section, {required bool isDrawer}) {
    return InkWell(
      onTap: () {
        setState(() => _selected = section);
        if (isDrawer) Navigator.pop(context); // drawer ise kapat
      },
      child: const SizedBox(height: 56, width: double.infinity),
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
