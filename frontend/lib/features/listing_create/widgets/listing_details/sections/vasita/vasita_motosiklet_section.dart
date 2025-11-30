import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../listing_details_types.dart';

class VasitaMotosikletSection extends StatelessWidget {
  const VasitaMotosikletSection({
    super.key,
    required this.draft,
    required this.zamanlamaTipleri,
    required this.sogutmalar,
  });

  final ListingDetailsDraft draft;
  final List<LabeledInt> zamanlamaTipleri;
  final List<LabeledInt> sogutmalar;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Motosiklet Detayları',
      child: ListingFormGrid(
        children: [
          ListingIntDropdown(
            label: 'Zamanlama',
            value: draft.zamanlamaTipi,
            items: zamanlamaTipleri,
            onChanged: draft.setZamanlamaTipi,
          ),
          ListingIntField(
            controller: draft.silindirSayisiCtrl,
            label: 'Silindir Sayısı *',
            hint: 'Örn: 2',
            required: true,
          ),
          ListingIntDropdown(
            label: 'Soğutma',
            value: draft.sogutma,
            items: sogutmalar,
            onChanged: draft.setSogutma,
          ),
        ],
      ),
    );
  }
}
