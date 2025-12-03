import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';   // path sende farklıysa düzelt

class AppSidebar extends StatefulWidget {
  final Function(String category, String? subCategory)? onCategorySelected;
  final VoidCallback? onFilterTap;
  final int activeFilterCount;

  const AppSidebar({
    super.key,
    this.onCategorySelected,
    this.onFilterTap,
    this.activeFilterCount = 0,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  String? _selectedCategory;
  String? _selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Başlık
          _buildHeader(),
          
          const Divider(color: AppColors.divider, height: 1),
          
          // Filtre Butonu
          _buildFilterButton(),
          
          const Divider(color: AppColors.divider, height: 1),
          
          // Kategoriler
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  // Tüm İlanlar
                  _buildAllListingsButton(),
                  
                  const SizedBox(height: 4),
                  
                  // Emlak Kategorisi
                  _SidebarCategory(
                    icon: Icons.home_work_outlined,
                    title: 'Emlak',
                    isExpanded: _selectedCategory == 'emlak',
                    onTap: () => _toggleCategory('emlak'),
                    subItems: const [
                      _SubItem(id: 'konut', title: 'Konut', icon: Icons.apartment),
                      _SubItem(id: 'arsa', title: 'Arsa', icon: Icons.landscape_outlined),
                      _SubItem(id: 'turistik', title: 'Turistik Tesis', icon: Icons.hotel_outlined),
                      _SubItem(id: 'devremulk', title: 'Devre Mülk', icon: Icons.calendar_month_outlined),
                    ],
                    selectedSubItem: _selectedCategory == 'emlak' ? _selectedSubCategory : null,
                    onSubItemTap: (subId) => _selectSubCategory('emlak', subId),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Vasıta Kategorisi
                  _SidebarCategory(
                    icon: Icons.directions_car_outlined,
                    title: 'Vasıta',
                    isExpanded: _selectedCategory == 'vasita',
                    onTap: () => _toggleCategory('vasita'),
                    subItems: const [
                      _SubItem(id: 'otomobil', title: 'Otomobil', icon: Icons.directions_car),
                      _SubItem(id: 'tir', title: 'Tır', icon: Icons.local_shipping_outlined),
                      _SubItem(id: 'karavan', title: 'Karavan', icon: Icons.rv_hookup),
                      _SubItem(id: 'motosiklet', title: 'Motosiklet', icon: Icons.two_wheeler),
                    ],
                    selectedSubItem: _selectedCategory == 'vasita' ? _selectedSubCategory : null,
                    onSubItemTap: (subId) => _selectSubCategory('vasita', subId),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            Icons.grid_view_rounded,
            color: AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            'Kategoriler',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = null;
        _selectedSubCategory = null;
      } else {
        _selectedCategory = category;
        _selectedSubCategory = null;
      }
    });
    widget.onCategorySelected?.call(category, null);
  }

  void _selectSubCategory(String category, String subCategory) {
    setState(() {
      _selectedCategory = category;
      _selectedSubCategory = subCategory;
    });
    widget.onCategorySelected?.call(category, subCategory);
  }

  void _selectAllListings() {
    setState(() {
      _selectedCategory = null;
      _selectedSubCategory = null;
    });
    widget.onCategorySelected?.call('all', null);
  }

  Widget _buildAllListingsButton() {
    final isSelected = _selectedCategory == null && _selectedSubCategory == null;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _selectAllListings,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.apps,
                  size: 20,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Tüm İlanlar',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onFilterTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.activeFilterCount > 0 
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.activeFilterCount > 0 
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  color: widget.activeFilterCount > 0 
                      ? AppColors.primary 
                      : AppColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Filtrele',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.activeFilterCount > 0 
                          ? AppColors.primary 
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                if (widget.activeFilterCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.activeFilterCount}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// KATEGORİ WIDGET'I - Genişletilebilir Ana Kategori
// ═══════════════════════════════════════════════════════════════════════════════
class _SidebarCategory extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<_SubItem> subItems;
  final String? selectedSubItem;
  final Function(String) onSubItemTap;

  const _SidebarCategory({
    required this.icon,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.subItems,
    required this.selectedSubItem,
    required this.onSubItemTap,
  });

  @override
  State<_SidebarCategory> createState() => _SidebarCategoryState();
}

class _SidebarCategoryState extends State<_SidebarCategory> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ana Kategori Başlığı
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: widget.isExpanded
                    ? AppColors.surfaceLight
                    : (_isHovered ? AppColors.surfaceLight : Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    color: widget.isExpanded
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: widget.isExpanded 
                            ? FontWeight.w600 
                            : FontWeight.w500,
                        color: widget.isExpanded
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: widget.isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Alt Kategoriler
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              children: widget.subItems.map((item) {
                return _SubItemWidget(
                  item: item,
                  isSelected: widget.selectedSubItem == item.id,
                  onTap: () => widget.onSubItemTap(item.id),
                );
              }).toList(),
            ),
          ),
          crossFadeState: widget.isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ALT KATEGORİ ITEM MODEL
// ═══════════════════════════════════════════════════════════════════════════════
class _SubItem {
  final String id;
  final String title;
  final IconData icon;

  const _SubItem({
    required this.id,
    required this.title,
    required this.icon,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// ALT KATEGORİ WIDGET'I
// ═══════════════════════════════════════════════════════════════════════════════
class _SubItemWidget extends StatefulWidget {
  final _SubItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _SubItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SubItemWidget> createState() => _SubItemWidgetState();
}

class _SubItemWidgetState extends State<_SubItemWidget> {
  bool _isHovered = false;

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
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primary.withValues(alpha: 0.15)
                : (_isHovered ? AppColors.surfaceLight : Colors.transparent),
            borderRadius: BorderRadius.circular(6),
            border: widget.isSelected
                ? Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1)
                : null,
          ),
          child: Row(
            children: [
              // Sol kenar çizgisi (indent göstergesi)
              Container(
                width: 2,
                height: 16,
                margin: const EdgeInsets.only(right: 14, left: 8),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              Icon(
                widget.item.icon,
                color: widget.isSelected
                    ? AppColors.primary
                    : AppColors.textTertiary,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.item.title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: widget.isSelected 
                        ? FontWeight.w600 
                        : FontWeight.w400,
                    color: widget.isSelected
                        ? AppColors.primary
                        : (_isHovered ? AppColors.textPrimary : AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

