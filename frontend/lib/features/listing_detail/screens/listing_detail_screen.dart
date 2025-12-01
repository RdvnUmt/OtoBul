import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/core/theme/colors.dart';
import '/core/models/listing_model.dart';
import '/core/data/mock_listings.dart';
import '/shared/app_footer.dart';

class ListingDetailScreen extends StatelessWidget {
  final String listingId;

  const ListingDetailScreen({super.key, required this.listingId});

  Listing? _findListing() {
    try {
      return MockListings.allListings.firstWhere((l) => l.id == listingId);
    } catch (_) {
      return null;
    }
  }

  /// HashCode -> string kısaysa substring patlamasın diye güvenli 8 hane üretir
  String _safeShortId(Object id) {
    final s = id.hashCode.abs().toString();
    if (s.length >= 8) return s.substring(0, 8);
    return s.padLeft(8, '0');
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return '${formatter.format(price)} TL';
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy', 'tr_TR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final listing = _findListing();

    if (listing == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.textTertiary),
              const SizedBox(height: 16),
              Text(
                'İlan bulunamadı',
                style: GoogleFonts.inter(fontSize: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Ana Sayfaya Dön'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildContent(context, listing),
          ),
          const SliverToBoxAdapter(
            child: AppFooter(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Listing listing) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(context),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleCard(listing),
                    const SizedBox(height: 16),
                    _buildImage(listing),
                    const SizedBox(height: 16),
                    _buildFavoriteButton(),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildDescriptionAndDetails(listing),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'İlanlara Dön',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleCard(Listing listing) {
    final listingNo = _safeShortId(listing.id);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listing.title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFF0F6FC),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlan No: $listingNo',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF8B949E),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _formatPrice(listing.price),
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFF6B6B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF8B949E)),
              const SizedBox(width: 4),
              Text(
                '${listing.city} / ${listing.district}',
                style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF8B949E)),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF8B949E)),
              const SizedBox(width: 4),
              Text(
                _formatDate(listing.createdAt),
                style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF8B949E)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Listing listing) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
        image: DecorationImage(
          image: NetworkImage(listing.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD97706), Color(0xFFB45309)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 20, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            'Favorilere Ekle',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionAndDetails(Listing listing) {
    final isVehicle = listing.category == 'vasita';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Açıklama',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0F6FC),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            listing.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFFC9D1D9),
            ),
          ),
          const Divider(color: Color(0xFF30363D), height: 32),
          Text(
            'İlan Detayları',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0F6FC),
            ),
          ),
          const SizedBox(height: 16),
          if (isVehicle) _buildVehicleDetails(listing) else _buildPropertyDetails(listing),
        ],
      ),
    );
  }

  Widget _buildVehicleDetails(Listing listing) {
    final d = listing.details;
    final listingNo = _safeShortId(listing.id);

    return Column(
      children: [
        _buildDetailRow('İlan No', listingNo),
        _buildDetailRow('İlan Tarihi', _formatDate(listing.createdAt)),
        const Divider(color: Color(0xFF30363D), height: 24),
        if (d['brand'] != null) _buildDetailRow('Marka', d['brand']),
        if (d['model'] != null) _buildDetailRow('Model', d['model']),
        if (d['year'] != null) _buildDetailRow('Model Yılı', d['year'].toString()),
        const Divider(color: Color(0xFF30363D), height: 24),
        if (d['km'] != null)
          _buildDetailRow('Kilometre', '${NumberFormat('#,###', 'tr_TR').format(d['km'])} km'),
        if (d['fuel'] != null) _buildDetailRow('Yakıt Tipi', d['fuel']),
        if (d['gear'] != null) _buildDetailRow('Vites', d['gear']),
        if (d['engineVolume'] != null) _buildDetailRow('Motor Hacmi', '${d['engineVolume']} cc'),
        if (d['enginePower'] != null) _buildDetailRow('Motor Gücü', '${d['enginePower']} hp'),
        if (d['color'] != null) _buildDetailRow('Renk', d['color']),
        if (d['condition'] != null) _buildDetailRow('Araç Durumu', d['condition']),
        const Divider(color: Color(0xFF30363D), height: 24),
        _buildDetailRow('Kimden', listing.sellerType),
        _buildDetailRow('Ağır Hasar Kaydı', d['heavyDamage'] == true ? 'Var' : 'Yok'),
        _buildDetailRow('Garanti', d['warranty'] ?? 'Garantisi Yok'),
        _buildDetailRow('Plaka / Uyruk', d['plateOrigin'] ?? 'Türkiye'),
        _buildDetailRow('Takas', 'Yapılır'),
        _buildDetailRow('Kredi Uygunluğu', 'Uygun'),
        if (d['bodyType'] != null) _buildDetailRow('Kasa Tipi', d['bodyType']),
        if (d['drivetrain'] != null) _buildDetailRow('Çekiş', d['drivetrain']),
        if (d['cylinderCount'] != null) _buildDetailRow('Silindir Sayısı', d['cylinderCount'].toString()),
        if (d['cooling'] != null) _buildDetailRow('Soğutma', d['cooling']),
        if (d['bedCount'] != null && listing.subCategory == 'karavan')
          _buildDetailRow('Yatak Sayısı', d['bedCount'].toString()),
        if (d['type'] != null) _buildDetailRow('Karavan Türü', d['type']),
        if (d['caravanType'] != null) _buildDetailRow('Karavan Tipi', d['caravanType']),
        if (d['cabinType'] != null) _buildDetailRow('Kabin', d['cabinType']),
        if (d['tireCondition'] != null) _buildDetailRow('Lastik Durumu', '%${d['tireCondition']}'),
        if (d['hasTrailer'] != null) _buildDetailRow('Dorse', d['hasTrailer'] == true ? 'Var' : 'Yok'),
      ],
    );
  }

  Widget _buildPropertyDetails(Listing listing) {
    final d = listing.details;
    final listingNo = _safeShortId(listing.id);

    return Column(
      children: [
        _buildDetailRow('İlan No', listingNo),
        _buildDetailRow('İlan Tarihi', _formatDate(listing.createdAt)),
        const Divider(color: Color(0xFF30363D), height: 24),
        if (d['grossM2'] != null) _buildDetailRow('m² (Brüt)', '${d['grossM2']} m²'),
        if (d['netM2'] != null) _buildDetailRow('m² (Net)', '${d['netM2']} m²'),
        if (d['deedStatus'] != null) _buildDetailRow('Tapu Durumu', d['deedStatus']),
        const Divider(color: Color(0xFF30363D), height: 24),
        if (d['roomCount'] != null) _buildDetailRow('Oda Sayısı', d['roomCount']),
        if (d['buildingAge'] != null) _buildDetailRow('Bina Yaşı', '${d['buildingAge']} yaşında'),
        if (d['floor'] != null) _buildDetailRow('Bulunduğu Kat', '${d['floor']}. Kat'),
        if (d['totalFloors'] != null) _buildDetailRow('Kat Sayısı', d['totalFloors'].toString()),
        if (d['heating'] != null) _buildDetailRow('Isıtma', d['heating']),
        if (d['bathroomCount'] != null) _buildDetailRow('Banyo Sayısı', d['bathroomCount'].toString()),
        if (d['kitchenType'] != null) _buildDetailRow('Mutfak Tipi', d['kitchenType']),
        if (d['hasParking'] != null) _buildDetailRow('Otopark', d['hasParking'] == true ? 'Var' : 'Yok'),
        if (d['hasElevator'] != null) _buildDetailRow('Asansör', d['hasElevator'] == true ? 'Var' : 'Yok'),
        if (d['hasBalcony'] != null) _buildDetailRow('Balkon', d['hasBalcony'] == true ? 'Var' : 'Yok'),
        if (d['isFurnished'] != null) _buildDetailRow('Eşyalı', d['isFurnished'] == true ? 'Evet' : 'Hayır'),
        if (d['usageStatus'] != null) _buildDetailRow('Kullanım Durumu', d['usageStatus']),
        if (d['isInComplex'] != null) _buildDetailRow('Site İçinde', d['isInComplex'] == true ? 'Evet' : 'Hayır'),
        if (d['complexName'] != null && d['complexName'] != '') _buildDetailRow('Site Adı', d['complexName']),
        if (d['dues'] != null && d['dues'] > 0) _buildDetailRow('Aidat', '${d['dues']} TL'),
        const Divider(color: Color(0xFF30363D), height: 24),
        if (d['zoningStatus'] != null) _buildDetailRow('İmar Durumu', d['zoningStatus']),
        if (d['blockNo'] != null) _buildDetailRow('Ada No', d['blockNo'].toString()),
        if (d['parcelNo'] != null) _buildDetailRow('Parsel No', d['parcelNo'].toString()),
        if (d['floorAreaRatio'] != null) _buildDetailRow('Kaks (Emsal)', d['floorAreaRatio']),
        if (d['area'] != null) _buildDetailRow('Alan', '${d['area']} m²'),
        if (d['roomCount'] != null && listing.subCategory == 'turistik')
          _buildDetailRow('Oda Sayısı', d['roomCount'].toString()),
        if (d['bedCount'] != null) _buildDetailRow('Yatak Sayısı', d['bedCount'].toString()),
        if (d['openArea'] != null) _buildDetailRow('Açık Alan', '${d['openArea']} m²'),
        if (d['closedArea'] != null) _buildDetailRow('Kapalı Alan', '${d['closedArea']} m²'),
        if (d['hasPool'] != null) _buildDetailRow('Havuz', d['hasPool'] == true ? 'Var' : 'Yok'),
        if (d['starRating'] != null) _buildDetailRow('Yıldız', '${d['starRating']} Yıldız'),
        if (d['buildingStatus'] != null) _buildDetailRow('Yapı Durumu', d['buildingStatus']),
        if (d['period'] != null) _buildDetailRow('Dönem', d['period']),
        if (d['capacity'] != null) _buildDetailRow('Kapasite', '${d['capacity']} Kişi'),
        const Divider(color: Color(0xFF30363D), height: 24),
        _buildDetailRow('Kimden', listing.sellerType),
        _buildDetailRow('Takas', 'Yapılır'),
        _buildDetailRow('Kredi Uygunluğu', 'Uygun'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF8B949E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFC9D1D9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
