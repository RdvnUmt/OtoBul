import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';
import '../../../core/data/mock_listings.dart';
import '../../../core/models/listing_model.dart';
import '../widgets/app_sidebar.dart';
import '../../../shared/app_footer.dart';
import '../../../shared/widgets/listing_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  String? _selectedSubCategory;

  void _onCategorySelected(String category, String? subCategory) {
    setState(() {
      _selectedCategory = category;
      _selectedSubCategory = subCategory;
    });
  }

  List<Listing> _getListings() {
    return MockListings.getListings(
      category: _selectedCategory,
      subCategory: _selectedSubCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Sol: Sidebar
          AppSidebar(
            onCategorySelected: _onCategorySelected,
          ),

          // Sağ: İlan Listesi + Footer
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final listings = _getListings();

    return Column(
      children: [
        // Başlık Bar (Sabit)
        _buildHeader(listings.length),

        // İçerik Alanı (Scroll edilebilir - Footer dahil)
        Expanded(
          child: listings.isEmpty
              ? _buildEmptyState()
              : _buildScrollableContent(listings),
        ),
      ],
    );
  }

  Widget _buildScrollableContent(List<Listing> listings) {
    return CustomScrollView(
      slivers: [
        // İlan Listesi
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= listings.length) return null;
                final listing = listings[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: index < listings.length - 1 ? 16 : 0),
                  child: ListingCard(
                    listing: listing,
                    onTap: () {
                      context.go('/ilan-detay/${listing.id}');
                    },
                    onFavoriteTap: () {
                      debugPrint('Favori tıklandı: ${listing.title}');
                    },
                  ),
                );
              },
              childCount: listings.length,
            ),
          ),
        ),

        // Footer (En altta)
        const SliverToBoxAdapter(
          child: AppFooter(),
        ),
      ],
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getContentIcon(),
            size: 24,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Text(
            _getContentTitle(),
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count ilan',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),
          // Sıralama Dropdown
          _buildSortDropdown(),
        ],
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(
            'Sırala: ',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            'Tarih (Yeni)',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
            _selectedCategory == null
                ? 'Sol menüden bir kategori seçerek başlayın.'
                : 'Bu kategoride henüz ilan bulunmamaktadır.',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
            ),
          ),
        ],
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

    return Icons.grid_view_rounded;
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

    return 'Tüm İlanlar';
  }
}
