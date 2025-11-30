import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../../listing_create_models.dart';
import 'emlak_arsa_section.dart';
import 'emlak_devremulk_section.dart';
import 'emlak_konut_section.dart';
import 'emlak_turistik_section.dart';
import 'emlak_yerleske_section.dart';

class EmlakSection extends StatelessWidget {
  const EmlakSection({
    super.key,
    required this.draft,
    required this.emlakCategory,
  });

  final ListingDetailsDraft draft;
  final ListingEmlakCategory emlakCategory;

  bool get _isArsa => emlakCategory == ListingEmlakCategory.arsa;
  bool get _isKonut => emlakCategory == ListingEmlakCategory.konut;
  bool get _isTuristik => emlakCategory == ListingEmlakCategory.turistik;
  bool get _isDevreMulk => emlakCategory == ListingEmlakCategory.devreMulk;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListingSection(
              title: 'Emlak',
              child: ListingFormGrid(
                children: [
                  ListingReadOnlyInfo(label: 'Emlak Türü', value: emlakCategory.label),
                  ListingIntField(
                    controller: draft.m2BrutCtrl,
                    label: 'Brüt m² *',
                    hint: 'Örn: 120',
                    required: true,
                  ),
                  ListingIntField(
                    controller: draft.m2NetCtrl,
                    label: 'Net m² *',
                    hint: 'Örn: 95',
                    required: true,
                  ),
                  ListingStringDropdown(
                    label: 'Tapu Durumu *',
                    value: draft.tapuDurumu,
                    items: const [
                      'Kat Mülkiyeti',
                      'Kat İrtifakı',
                      'Hisseli Tapu',
                      'Müstakil Tapu',
                      'Belirtilmemiş',
                    ],
                    onChanged: draft.setTapuDurumu,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            if (_isArsa) ...[
              EmlakArsaSection(draft: draft),
            ] else ...[
              EmlakYerleskeSection(draft: draft),
              const SizedBox(height: 12),

              if (_isKonut) ...[
                EmlakKonutSection(draft: draft),
              ] else if (_isTuristik) ...[
                EmlakTuristikSection(draft: draft),
              ] else if (_isDevreMulk) ...[
                EmlakDevreMulkSection(draft: draft),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${emlakCategory.label} için ek detay alanı yok. (Bina/Yerleşke bilgileri yeterli)',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ],
          ],
        );
      },
    );
  }
}
