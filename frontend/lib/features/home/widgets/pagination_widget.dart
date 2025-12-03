import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';

/// Pagination Widget - Sayfa numaraları ve navigasyon
class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final Function(int) onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Toplam ilan sayısı
          Text(
            'Toplam $totalCount ilan',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 24),
          
          // Önceki butonu
          _buildNavButton(
            icon: Icons.chevron_left,
            onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            tooltip: 'Önceki',
          ),
          const SizedBox(width: 8),

          // Sayfa numaraları
          ..._buildPageNumbers(),

          const SizedBox(width: 8),
          // Sonraki butonu
          _buildNavButton(
            icon: Icons.chevron_right,
            onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
            tooltip: 'Sonraki',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    final List<Widget> pages = [];
    
    // Gösterilecek sayfa numaralarını hesapla
    int startPage = 1;
    int endPage = totalPages;
    
    if (totalPages > 7) {
      if (currentPage <= 4) {
        endPage = 5;
      } else if (currentPage >= totalPages - 3) {
        startPage = totalPages - 4;
      } else {
        startPage = currentPage - 2;
        endPage = currentPage + 2;
      }
    }

    // İlk sayfa
    if (startPage > 1) {
      pages.add(_buildPageButton(1));
      if (startPage > 2) {
        pages.add(_buildEllipsis());
      }
    }

    // Orta sayfalar
    for (int i = startPage; i <= endPage; i++) {
      pages.add(_buildPageButton(i));
    }

    // Son sayfa
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pages.add(_buildEllipsis());
      }
      pages.add(_buildPageButton(totalPages));
    }

    return pages;
  }

  Widget _buildPageButton(int page) {
    final isSelected = page == currentPage;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isSelected ? null : () => onPageChanged(page),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isSelected ? null : Border.all(color: AppColors.border),
            ),
            child: Text(
              '$page',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '...',
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: onPressed != null ? AppColors.border : AppColors.border.withOpacity(0.5),
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: onPressed != null ? AppColors.textSecondary : AppColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
