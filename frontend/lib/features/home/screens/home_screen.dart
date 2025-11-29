import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';   // path sende farklıysa düzelt
import '../../../shared/app_header.dart'; // path sende farklıysa düzelt
import '../widgets/app_sidebar.dart';
import '../../../shared/app_footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  String? _selectedSubCategory;

  void _navigateToHome(BuildContext context) {
    setState(() {
      _selectedCategory = null;
      _selectedSubCategory = null;
    });
  }

  void _openLoginDialog(BuildContext context) {
    debugPrint('Giriş yap tıklandı');
  }

  void _openRegisterDialog(BuildContext context) {
    debugPrint('Hesap oluştur tıklandı');
  }

  void _onCategorySelected(String category, String? subCategory) {
    setState(() {
      _selectedCategory = category;
      _selectedSubCategory = subCategory;
    });
    debugPrint('Kategori: $category, Alt Kategori: $subCategory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Ana İçerik: Sidebar + İlanlar + Footer
          Expanded(
            child: Row(
              children: [
                // Sol: Sidebar
                AppSidebar(
                  onCategorySelected: _onCategorySelected,
                ),
                
                // Sağ: İlan Listesi + Footer (Scroll edilebilir)
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        // İçerik Alanı (Esnek)
        Expanded(
          child: _buildContentArea(),
        ),
        
        // Footer
        const AppFooter(),
      ],
    );
  }

  Widget _buildContentArea() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getContentIcon(),
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 20),
            Text(
              _getContentTitle(),
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getContentSubtitle(),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getContentIcon() {
    if (_selectedSubCategory != null) {
      switch (_selectedSubCategory) {
        case 'konut':
          return Icons.apartment;
        case 'arsa':
          return Icons.landscape_outlined;
        case 'turistik':
          return Icons.hotel_outlined;
        case 'devremulk':
          return Icons.other_houses_outlined;
        case 'otomobil':
          return Icons.directions_car;
        case 'tir':
          return Icons.local_shipping_outlined;
        case 'karavan':
          return Icons.rv_hookup;
        case 'motosiklet':
          return Icons.two_wheeler;
      }
    }
    
    if (_selectedCategory == 'emlak') {
      return Icons.home_work_outlined;
    } else if (_selectedCategory == 'vasita') {
      return Icons.directions_car_outlined;
    }
    
    return Icons.search;
  }

  String _getContentTitle() {
    if (_selectedSubCategory != null) {
      switch (_selectedSubCategory) {
        case 'konut':
          return 'Konut İlanları';
        case 'arsa':
          return 'Arsa İlanları';
        case 'turistik':
          return 'Turistik Tesis İlanları';
        case 'devremulk':
          return 'Devre Mülk İlanları';
        case 'otomobil':
          return 'Otomobil İlanları';
        case 'tir':
          return 'Tır İlanları';
        case 'karavan':
          return 'Karavan İlanları';
        case 'motosiklet':
          return 'Motosiklet İlanları';
      }
    }
    
    if (_selectedCategory == 'emlak') {
      return 'Emlak İlanları';
    } else if (_selectedCategory == 'vasita') {
      return 'Vasıta İlanları';
    }
    
    return 'İlan Ara';
  }

  String _getContentSubtitle() {
    if (_selectedSubCategory != null || _selectedCategory != null) {
      return 'Bu kategoride henüz ilan bulunmamaktadır.';
    }
    return 'Sol menüden bir kategori seçerek başlayın.';
  }
}
