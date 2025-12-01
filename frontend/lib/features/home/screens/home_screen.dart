import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';
import '../../../core/data/mock_listings.dart';
import '../../../core/models/listing_model.dart';
import '../../../core/services/listing_service.dart';
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
  
  // API verisi
  List<Listing> _apiListings = [];
  bool _isLoading = true;
  bool _useApi = true; // API mi Mock mu kullanılacak
  String? _errorMessage;

  final ListingService _listingService = ListingService();

  @override
  void initState() {
    super.initState();
    _loadListings();
  }

  /// API'den ilanları yükle
  Future<void> _loadListings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      List<Listing> listings;
      
      if (_selectedSubCategory != null) {
        listings = await _listingService.getListingsBySubCategory(_selectedSubCategory!);
      } else if (_selectedCategory != null) {
        listings = await _listingService.getListingsByCategory(_selectedCategory!);
      } else {
        listings = await _listingService.getAllListings();
      }

      setState(() {
        _apiListings = listings;
        _isLoading = false;
        _useApi = listings.isNotEmpty;
      });
    } catch (e) {
      debugPrint('API Hatası: $e');
      setState(() {
        _isLoading = false;
        _useApi = false;
        _errorMessage = 'API bağlantısı kurulamadı. Mock veriler gösteriliyor.';
      });
    }
  }

  void _onCategorySelected(String category, String? subCategory) {
    setState(() {
      _selectedCategory = category;
      _selectedSubCategory = subCategory;
    });
    _loadListings(); // Kategori değişince yeniden yükle
  }

  List<Listing> _getListings() {
    // API verisi varsa onu kullan, yoksa mock data
    if (_useApi && _apiListings.isNotEmpty) {
      return _apiListings;
    }
    
    // Fallback: Mock data
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
    if (_isLoading) {
      return _buildLoadingState();
    }

    final listings = _getListings();

    return Column(
      children: [
        // Başlık Bar (Sabit)
        _buildHeader(listings.length),

        // Hata mesajı banner
        if (_errorMessage != null) _buildErrorBanner(),

        // İçerik Alanı (Scroll edilebilir - Footer dahil)
        Expanded(
          child: listings.isEmpty
              ? _buildEmptyState()
              : _buildScrollableContent(listings),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'İlanlar yükleniyor...',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.orange.shade100,
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade800, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.orange.shade900,
              ),
            ),
          ),
          TextButton(
            onPressed: _loadListings,
            child: Text(
              'Tekrar Dene',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent(List<Listing> listings) {
    return RefreshIndicator(
      onRefresh: _loadListings,
      color: AppColors.primary,
      child: CustomScrollView(
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
                        context.go('/ilan-detay/${listing.id}', extra: listing);
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
      ),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$count ilan',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                if (_useApi && _apiListings.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  Icon(
                    Icons.cloud_done_outlined,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          // Refresh butonu
          IconButton(
            onPressed: _loadListings,
            icon: const Icon(Icons.refresh, size: 20),
            color: AppColors.textSecondary,
            tooltip: 'Yenile',
          ),
          const SizedBox(width: 8),
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
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadListings,
            icon: const Icon(Icons.refresh),
            label: const Text('Yeniden Dene'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
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
