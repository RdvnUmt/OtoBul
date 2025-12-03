import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';
import '../../../core/services/listing_service.dart';

/// Filtreleme Ekranı - Kategoriye göre dinamik filtreler gösterir
class FilterScreen extends StatefulWidget {
  final String? category; // 'emlak' veya 'vasita'
  final String? subCategory; // 'konut', 'otomobil' vb.
  final FilterParams currentFilters;
  final Function(FilterParams) onApplyFilters;

  const FilterScreen({
    super.key,
    this.category,
    this.subCategory,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late FilterParams _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 350,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            left: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            const Divider(color: AppColors.divider, height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ortak Filtre
                    _buildSectionTitle('Genel'),
                    const SizedBox(height: 12),
                    _buildDropdown(
                      label: 'İlan Tipi',
                      value: _filters.ilanTipi,
                      items: const ['Satılık', 'Kiralık'],
                      onChanged: (v) => setState(() => _filters = _filters.copyWith(ilanTipi: v)),
                    ),

                    // Konut Filtreleri (3 adet)
                    if (widget.subCategory == 'konut') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Konut Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Oda Sayısı',
                        value: _filters.odaSayisi,
                        items: const ['1+0', '1+1', '2+1', '3+1', '4+1', '5+1'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(odaSayisi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Isıtma Tipi',
                        value: _filters.isitma,
                        items: const ['Doğalgaz', 'Merkezi', 'Kombi', 'Soba', 'Klima'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(isitma: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Kullanım Durumu',
                        value: _filters.kullanimDurumu,
                        items: const ['Boş', 'Kiralık', 'Mal Sahibi'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(kullanimDurumu: v)),
                      ),
                    ],
                    
                    // Arsa Filtreleri (3 adet)
                    if (widget.subCategory == 'arsa') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Arsa Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'İmar Durumu',
                        value: _filters.imarDurumu,
                        items: const ['İmarlı', 'İmarsız', 'Tarım Arazisi'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(imarDurumu: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Tapu Durumu',
                        value: _filters.tapuDurumu,
                        items: const ['Kat Mülkiyetli', 'Hisseli Tapu', 'Müstakil Tapu'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(tapuDurumu: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Emlak Tipi',
                        value: _filters.emlakTipi,
                        items: const ['Arsa', 'Tarla', 'Bahçe'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(emlakTipi: v)),
                      ),
                    ],
                    
                    // Turistik Filtreleri (3 adet)
                    if (widget.subCategory == 'turistik') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Turistik Tesis Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Tesis Tipi',
                        value: _filters.turistikTipi,
                        items: const ['Otel', 'Apart', 'Pansiyon', 'Tatil Köyü'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(turistikTipi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Yıldız Sayısı',
                        value: _filters.yildizSayisi,
                        items: const ['1 Yıldız', '2 Yıldız', '3 Yıldız', '4 Yıldız', '5 Yıldız'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(yildizSayisi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Konum',
                        value: _filters.konumTipi,
                        items: const ['Deniz Kenarı', 'Şehir Merkezi', 'Dağ'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(konumTipi: v)),
                      ),
                    ],
                    
                    // Devre Mülk Filtreleri (3 adet)
                    if (widget.subCategory == 'devremulk') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Devre Mülk Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Sezon',
                        value: _filters.sezon,
                        items: const ['Yaz', 'Kış', 'Bahar', 'Sonbahar'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(sezon: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Hafta',
                        value: _filters.hafta,
                        items: const ['1. Hafta', '2. Hafta', '3. Hafta', '4. Hafta'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(hafta: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Bölge',
                        value: _filters.bolge,
                        items: const ['Ege', 'Akdeniz', 'Marmara', 'Karadeniz'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(bolge: v)),
                      ),
                    ],
                    
                    // Otomobil Filtreleri (3 adet)
                    if (widget.subCategory == 'otomobil') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Otomobil Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Vites Tipi',
                        value: _filters.vites,
                        items: const ['Düz', 'Otomatik', 'Yarı Otomatik'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(vites: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Yakıt Tipi',
                        value: _filters.yakitTipi,
                        items: const ['Benzin', 'Dizel', 'LPG', 'Hibrit', 'Elektrik'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(yakitTipi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Kasa Tipi',
                        value: _filters.kasaTipi,
                        items: const ['Sedan', 'Hatchback', 'SUV', 'Coupe'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(kasaTipi: v)),
                      ),
                    ],
                    
                    // Motosiklet Filtreleri (3 adet)
                    if (widget.subCategory == 'motosiklet') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Motosiklet Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Motor Tipi',
                        value: _filters.motorTipi,
                        items: const ['Naked', 'Sport', 'Touring', 'Chopper'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(motorTipi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Motor Hacmi',
                        value: _filters.motorHacmi,
                        items: const ['0-125 cc', '126-250 cc', '251-500 cc', '500+ cc'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(motorHacmi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Marka',
                        value: _filters.motorMarka,
                        items: const ['Honda', 'Yamaha', 'Kawasaki', 'Suzuki'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(motorMarka: v)),
                      ),
                    ],
                    
                    // Karavan Filtreleri (3 adet)
                    if (widget.subCategory == 'karavan') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Karavan Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Karavan Tipi',
                        value: _filters.karavanTipi,
                        items: const ['Çekme Karavan', 'Motokaravan', 'Kamper Van'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(karavanTipi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Marka',
                        value: _filters.karavanMarka,
                        items: const ['Hobby', 'Knaus', 'Dethleffs', 'Adria'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(karavanMarka: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Yatak Kapasitesi',
                        value: _filters.yatakKapasitesi,
                        items: const ['2 Kişi', '4 Kişi', '6 Kişi'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(yatakKapasitesi: v)),
                      ),
                    ],
                    
                    // Tır Filtreleri (3 adet)
                    if (widget.subCategory == 'tir') ...[
                      const SizedBox(height: 24),
                      _buildSectionTitle('Tır Filtreleri'),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Tır Tipi',
                        value: _filters.tirTipi,
                        items: const ['Çekici', 'Kamyon', 'Dorse', 'Tanker'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(tirTipi: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Marka',
                        value: _filters.tirMarka,
                        items: const ['Mercedes', 'Volvo', 'Scania', 'MAN'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(tirMarka: v)),
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown(
                        label: 'Dingil',
                        value: _filters.dingil,
                        items: const ['4x2', '6x2', '6x4', '8x4'],
                        onChanged: (v) => setState(() => _filters = _filters.copyWith(dingil: v)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Divider(color: AppColors.divider, height: 1),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(
            Icons.filter_list,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Filtreler',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: AppColors.textSecondary,
            tooltip: 'Kapat',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Temizle',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Uygula',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                'Seçiniz',
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.textTertiary),
              ),
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary),
              dropdownColor: AppColors.surface,
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    'Tümü',
                    style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
                ...items.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                )),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      _filters = const FilterParams();
    });
  }

  void _applyFilters() {
    final updatedFilters = _filters.copyWith(page: 1);
    widget.onApplyFilters(updatedFilters);
    Navigator.of(context).pop();
  }
}
