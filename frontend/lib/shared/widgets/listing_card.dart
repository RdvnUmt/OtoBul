// listing_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';
import '/core/models/listing_model.dart';
import 'package:intl/intl.dart';

/// ListingCard için Listing'e alternatif (create preview gibi yerlerde)
class ListingCardVm {
  final String listingNo;
  final String title;
  final String description;

  /// 'vasita' ise araç detay layoutu, değilse emlak layoutu
  final String category;

  final String sellerType;
  final String city;
  final String district;

  final DateTime createdAt;
  final double price;

  final bool isFavorite;

  /// ListingCard mevcut mantığıyla uyumlu (km, fuel, gear... veya grossM2, netM2...)
  final Map<String, dynamic> details;

  /// İstersen asset, istersen network
  final ImageProvider? imageProvider;

  const ListingCardVm({
    required this.listingNo,
    required this.title,
    required this.description,
    required this.category,
    required this.sellerType,
    required this.city,
    required this.district,
    required this.createdAt,
    required this.price,
    required this.isFavorite,
    required this.details,
    this.imageProvider,
  });

  factory ListingCardVm.fromListing(Listing listing) {
    return ListingCardVm(
      listingNo: _safeShortId(listing.id),
      title: listing.title,
      description: listing.description,
      category: listing.category,
      sellerType: listing.sellerType,
      city: listing.city,
      district: listing.district,
      createdAt: listing.createdAt,
      price: listing.price,
      isFavorite: listing.isFavorite,
      details: listing.details,
      imageProvider: NetworkImage(listing.imageUrl),
    );
  }

  static String _safeShortId(Object id) {
    final s = id.hashCode.abs().toString();
    // substring crash olmasın:
    if (s.length >= 8) return s.substring(0, 8);
    return s.padLeft(8, '0');
  }
}

/// İlan Kartı Widget'ı - Sahibinden.com tarzı tasarım
class ListingCard extends StatefulWidget {
  final Listing? listing;
  final ListingCardVm? vm;

  final VoidCallback? onTap;

  /// ⭐ Dışarıdan yıldız butonuna aksiyon bağlamak için
  final VoidCallback? onFavoriteTap;

  /// Normal kullanım (mevcut kullanımın aynısı)
  const ListingCard({
    super.key,
    required Listing listing,
    this.onTap,
    this.onFavoriteTap,
  })  : listing = listing,
        vm = null;

  /// Preview / create screen gibi yerler için Listing modeline gerek kalmadan kullanım
  const ListingCard.preview({
    super.key,
    required ListingCardVm vm,
    this.onTap,
    this.onFavoriteTap,
  })  : vm = vm,
        listing = null;

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  bool _isHovered = false;

  ListingCardVm get _data {
    if (widget.vm != null) return widget.vm!;
    return ListingCardVm.fromListing(widget.listing!);
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return '${formatter.format(price)} TL';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün';
    } else if (difference.inDays == 1) {
      return 'Dün';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return DateFormat('d MMMM yyyy', 'tr_TR').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = _data;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceLight : AppColors.surface,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isHovered ? AppColors.borderLight : AppColors.border,
              width: 1,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sol: Görsel
                _buildImage(d),

                // Orta: Detaylar
                Expanded(child: _buildDetails(d)),

                // Sağ: Konum, Tarih, Fiyat
                _buildRightSection(d),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(ListingCardVm d) {
    return Stack(
      children: [
        Container(
          width: 220,
          height: 165,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            image: d.imageProvider != null
                ? DecorationImage(
                    image: d.imageProvider!,
                    fit: BoxFit.cover,
                  )
                : null,
            color: d.imageProvider == null ? AppColors.surfaceLight : null,
          ),
          child: d.imageProvider == null
              ? Center(
                  child: Icon(
                    Icons.photo_rounded,
                    color: AppColors.textTertiary,
                    size: 34,
                  ),
                )
              : null,
        ),

        // İlan No
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#${d.listingNo}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(ListingCardVm d) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İlan No
          Text(
            'İlan No: ${d.listingNo}',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 6),

          // Başlık
          Text(
            d.title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Açıklama
          Text(
            d.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Detay Satırları
          _buildDetailRows(d),
        ],
      ),
    );
  }

  Widget _buildDetailRows(ListingCardVm d) {
    final details = d.details;
    final isVehicle = d.category == 'vasita';

    if (isVehicle) {
      return _buildVehicleDetails(details, d.sellerType);
    } else {
      return _buildPropertyDetails(details, d.sellerType);
    }
  }

  Widget _buildVehicleDetails(Map<String, dynamic> details, String sellerType) {
    final km = details['km'];
    final fuel = details['fuel'];
    final gear = details['gear'];
    final engineVolume = details['engineVolume'];
    final enginePower = details['enginePower'];
    final condition = details['condition'];

    return Column(
      children: [
        Row(
          children: [
            if (km != null) _buildDetailItem('${_formatNumber(km)} km', AppColors.info),
            if (km != null) const SizedBox(width: 24),
            _buildDetailItem(sellerType, AppColors.textSecondary),
            const SizedBox(width: 24),
            if (fuel != null) _buildDetailItem(fuel, AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            if (gear != null) _buildDetailItem(gear, AppColors.textSecondary),
            if (gear != null) const SizedBox(width: 24),
            if (engineVolume != null) _buildDetailItem('$engineVolume cc', AppColors.textSecondary),
            if (engineVolume != null) const SizedBox(width: 24),
            if (enginePower != null) _buildDetailItem('$enginePower hp', AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildDetailItem('Garantisi Yok', AppColors.textSecondary),
            const SizedBox(width: 24),
            _buildDetailItem('Önden Çekiş', AppColors.textSecondary),
            const SizedBox(width: 24),
            if (condition != null) _buildDetailItem(condition, AppColors.textSecondary),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyDetails(Map<String, dynamic> details, String sellerType) {
    final grossM2 = details['grossM2'];
    final netM2 = details['netM2'];
    final roomCount = details['roomCount'];
    final buildingAge = details['buildingAge'];
    final floor = details['floor'];
    final heating = details['heating'];

    return Column(
      children: [
        Row(
          children: [
            if (grossM2 != null) _buildDetailItem('$grossM2 m² (Brüt)', AppColors.info),
            if (grossM2 != null) const SizedBox(width: 24),
            if (netM2 != null) _buildDetailItem('$netM2 m² (Net)', AppColors.textSecondary),
            if (netM2 != null) const SizedBox(width: 24),
            if (roomCount != null) _buildDetailItem('$roomCount', AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            if (buildingAge != null) _buildDetailItem('$buildingAge Yaşında', AppColors.textSecondary),
            if (buildingAge != null) const SizedBox(width: 24),
            if (floor != null) _buildDetailItem('$floor. Kat', AppColors.textSecondary),
            if (floor != null) const SizedBox(width: 24),
            if (heating != null) _buildDetailItem(heating, AppColors.textSecondary),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildDetailItem(sellerType, AppColors.textSecondary),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.arrow_forward_ios,
          size: 10,
          color: AppColors.accent,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRightSection(ListingCardVm d) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Favori Butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Konum
              Expanded(
                child: Text(
                  '${d.city} / ${d.district}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.info,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Favori (✅ InkWell ile ripple + dışarıdan callback)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onFavoriteTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      d.isFavorite ? Icons.star : Icons.star_border,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Tarih
          Text(
            _formatDate(d.createdAt),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),

          const Spacer(),

          // Fiyat
          Text(
            _formatPrice(d.price),
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return formatter.format(number);
  }
}
