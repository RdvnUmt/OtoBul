import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../listing_details_types.dart';

class VasitaOtomobilSection extends StatelessWidget {
  const VasitaOtomobilSection({
    super.key,
    required this.draft,
    required this.kasaTipleri,
    required this.cekisTipleri,
  });

  final ListingDetailsDraft draft;
  final List<LabeledInt> kasaTipleri;
  final List<LabeledInt> cekisTipleri;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Otomobil Detayları',
      child: ListingFormGrid(
        children: [
          ListingIntDropdown(
            label: 'Kasa Tipi *',
            value: draft.kasaTipi,
            items: kasaTipleri,
            onChanged: draft.setKasaTipi,
          ),
          ListingIntDropdown(
            label: 'Çekiş *',
            value: draft.cekis,
            items: cekisTipleri,
            onChanged: draft.setCekis,
          ),
        ],
      ),
    );
  }
}
