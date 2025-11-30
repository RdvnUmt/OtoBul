import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';

class EmlakArsaSection extends StatelessWidget {
  const EmlakArsaSection({super.key, required this.draft});

  final ListingDetailsDraft draft;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Arsa Detayları',
      child: ListingFormGrid(
        children: [
          ListingStringDropdown(
            label: 'İmar Durumu',
            value: draft.imarDurumu ?? 'Seçilmedi',
            items: const ['Seçilmedi', 'İmarlı', 'İmarsız', 'Konut', 'Ticari', 'Sanayi', 'Tarla'],
            onChanged: (v) => draft.setImarDurumu(v == 'Seçilmedi' ? null : v),
          ),
          ListingIntField(
            controller: draft.adaNoCtrl,
            label: 'Ada No *',
            hint: 'Örn: 123',
            required: true,
          ),
          ListingIntField(
            controller: draft.parselNoCtrl,
            label: 'Parsel No *',
            hint: 'Örn: 45',
            required: true,
          ),
          ListingIntField(
            controller: draft.paftaNoCtrl,
            label: 'Pafta No *',
            hint: 'Örn: 7',
            required: true,
          ),
          ListingTextField(
            controller: draft.kaksEmsalCtrl,
            label: 'KAKS / Emsal',
            hint: 'Örn: 1.50',
            required: false,
            maxLength: 50,
          ),
          ListingTextField(
            controller: draft.gabariCtrl,
            label: 'Gabari',
            hint: 'Örn: 9.50',
            required: false,
            maxLength: 50,
          ),
        ],
      ),
    );
  }
}
