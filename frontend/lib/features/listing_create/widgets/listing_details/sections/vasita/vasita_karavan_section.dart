import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../listing_details_types.dart';

class VasitaKaravanSection extends StatelessWidget {
  const VasitaKaravanSection({
    super.key,
    required this.draft,
    required this.karavanTurleri,
    required this.karavanTipleri,
  });

  final ListingDetailsDraft draft;
  final List<LabeledInt> karavanTurleri;
  final List<LabeledInt> karavanTipleri;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Karavan Detayları',
      child: ListingFormGrid(
        children: [
          ListingIntField(
            controller: draft.yatakSayisiKaravanCtrl,
            label: 'Yatak Sayısı *',
            hint: 'Örn: 4',
            required: true,
          ),
          ListingIntDropdown(
            label: 'Karavan Türü *',
            value: draft.karavanTuru,
            items: karavanTurleri,
            onChanged: draft.setKaravanTuru,
          ),
          ListingIntDropdown(
            label: 'Karavan Tipi *',
            value: draft.karavanTipi,
            items: karavanTipleri,
            onChanged: draft.setKaravanTipi,
          ),
        ],
      ),
    );
  }
}
