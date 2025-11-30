import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../listing_details_options.dart';
import '../../../listing_create_models.dart';
import 'vasita_karavan_section.dart';
import 'vasita_motosiklet_section.dart';
import 'vasita_otomobil_section.dart';
import 'vasita_tir_section.dart';

class VasitaSection extends StatelessWidget {
  const VasitaSection({
    super.key,
    required this.draft,
    required this.vasitaCategory,
  });

  final ListingDetailsDraft draft;
  final ListingVasitaCategory vasitaCategory;

  bool get _isOtomobil => vasitaCategory == ListingVasitaCategory.otomobil;
  bool get _isMoto => vasitaCategory == ListingVasitaCategory.motosiklet;
  bool get _isKaravan => vasitaCategory == ListingVasitaCategory.karavan;
  bool get _isTir => vasitaCategory == ListingVasitaCategory.tir;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListingSection(
              title: 'Vasıta',
              child: ListingFormGrid(
                children: [
                  ListingReadOnlyInfo(label: 'Vasıta Türü', value: vasitaCategory.label),

                  ListingTextField(
                    controller: draft.markaNameCtrl,
                    label: 'Marka *',
                    hint: 'Örn: Hyundai',
                    maxLength: 50,
                    required: true,
                  ),
                  ListingTextField(
                    controller: draft.seriIsmiCtrl,
                    label: 'Seri *',
                    hint: 'Örn: i20',
                    maxLength: 50,
                    required: true,
                  ),
                  ListingTextField(
                    controller: draft.modelIsmiCtrl,
                    label: 'Model *',
                    hint: 'Örn: 1.4 CRDi Elite',
                    maxLength: 50,
                    required: true,
                  ),
                  ListingIntField(
                    controller: draft.modelYiliCtrl,
                    label: 'Model Yılı',
                    hint: 'Örn: 2016',
                    required: false,
                  ),
                  ListingTextField(
                    controller: draft.menseiCtrl,
                    label: 'Menşei',
                    hint: 'Örn: Güney Kore',
                    maxLength: 50,
                    required: false,
                  ),

                  ListingStringDropdown(
                    label: 'Yakıt Tipi *',
                    value: draft.yakit,
                    items: const ['Benzin', 'Dizel', 'LPG', 'Hibrit', 'Elektrik'],
                    onChanged: draft.setYakit,
                  ),
                  ListingStringDropdown(
                    label: 'Vites *',
                    value: draft.vites,
                    items: const ['Düz', 'Otomatik', 'Yarı Otomatik'],
                    onChanged: draft.setVites,
                  ),
                  ListingStringDropdown(
                    label: 'Araç Durumu *',
                    value: draft.aracDurumu,
                    items: const ['Sıfır', 'İkinci El'],
                    onChanged: draft.setAracDurumu,
                  ),

                  ListingIntField(
                    controller: draft.kmCtrl,
                    label: 'Kilometre *',
                    hint: 'Örn: 138000',
                    required: true,
                  ),
                  ListingIntField(
                    controller: draft.motorGucuCtrl,
                    label: 'Motor Gücü (HP) *',
                    hint: 'Örn: 90',
                    required: true,
                  ),
                  ListingIntField(
                    controller: draft.motorHacmiCtrl,
                    label: 'Motor Hacmi (cc) *',
                    hint: 'Örn: 1396',
                    required: true,
                  ),
                  ListingTextField(
                    controller: draft.renkCtrl,
                    label: 'Renk *',
                    hint: 'Örn: Beyaz',
                    maxLength: 50,
                    required: true,
                  ),
                  ListingStringDropdown(
                    label: 'Garanti *',
                    value: draft.garanti,
                    items: const ['Yok', 'Var', 'Üretici', 'Yetkili Servis'],
                    onChanged: draft.setGaranti,
                  ),
                  ListingSwitchTile(
                    label: 'Ağır hasar kaydı var',
                    value: draft.agirHasar,
                    onChanged: draft.setAgirHasar,
                  ),
                  ListingStringDropdown(
                    label: 'Plaka uyruk *',
                    value: draft.plakaUyruk,
                    items: const ['TR', 'DE', 'NL'],
                    onChanged: draft.setPlakaUyruk,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            if (_isOtomobil)
              VasitaOtomobilSection(
                draft: draft,
                kasaTipleri: ListingDetailsOptions.kasaTipleri,
                cekisTipleri: ListingDetailsOptions.cekisTipleri,
              )
            else if (_isMoto)
              VasitaMotosikletSection(
                draft: draft,
                zamanlamaTipleri: ListingDetailsOptions.zamanlamaTipleri,
                sogutmalar: ListingDetailsOptions.sogutmalar,
              )
            else if (_isKaravan)
              VasitaKaravanSection(
                draft: draft,
                karavanTurleri: ListingDetailsOptions.karavanTurleri,
                karavanTipleri: ListingDetailsOptions.karavanTipleri,
              )
            else if (_isTir)
              VasitaTirSection(
                draft: draft,
                kabinTipleri: ListingDetailsOptions.kabinTipleri,
              ),
          ],
        );
      },
    );
  }
}
