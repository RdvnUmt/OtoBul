import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';
import '/core/models/listing_model.dart';
import 'package:intl/intl.dart';

/// İlan Kartı Widget'ı - Sahibinden.com tarzı tasarım
class ListingCard extends StatefulWidget {
  final Listing listing;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ListingCard({
    super.key,
    required this.listing,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  bool _isHovered = false;

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
                _buildImage(),

                // Orta: Detaylar
                Expanded(
                  child: _buildDetails(),
                ),

                // Sağ: Konum, Tarih, Fiyat
                _buildRightSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
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
            image: DecorationImage(
              image: NetworkImage(widget.listing.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
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
              '#${widget.listing.id.hashCode.abs().toString().substring(0, 8)}',
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

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İlan No
          Text(
            'İlan No: ${widget.listing.id.hashCode.abs().toString().substring(0, 8)}',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 6),

          // Başlık
          Text(
            widget.listing.title,
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
            widget.listing.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Detay Satırları
          _buildDetailRows(),
        ],
      ),
    );
  }

  Widget _buildDetailRows() {
    final details = widget.listing.details;
    final isVehicle = widget.listing.category == 'vasita';

    if (isVehicle) {
      return _buildVehicleDetails(details);
    } else {
      return _buildPropertyDetails(details);
    }
  }

  Widget _buildVehicleDetails(Map<String, dynamic> details) {
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
            _buildDetailItem(widget.listing.sellerType, AppColors.textSecondary),
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

  Widget _buildPropertyDetails(Map<String, dynamic> details) {
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
            _buildDetailItem(widget.listing.sellerType, AppColors.textSecondary),
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

  Widget _buildRightSection() {
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
                  '${widget.listing.city} / ${widget.listing.district}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.info,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Favori
              GestureDetector(
                onTap: widget.onFavoriteTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    widget.listing.isFavorite ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Tarih
          Text(
            _formatDate(widget.listing.createdAt),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),

          const Spacer(),

          // Fiyat
          Text(
            _formatPrice(widget.listing.price),
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

