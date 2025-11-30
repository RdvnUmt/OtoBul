import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';

class EmlakTuristikSection extends StatelessWidget {
  const EmlakTuristikSection({super.key, required this.draft});

  final ListingDetailsDraft draft;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Turistik Tesis Detayları',
      child: ListingFormGrid(
        children: [
          ListingIntField(controller: draft.apartSayisiCtrl, label: 'Apart Sayısı', hint: 'Örn: 12', required: false),
          ListingIntField(controller: draft.yatakSayisiTesisCtrl, label: 'Yatak Sayısı', hint: 'Örn: 40', required: false),
          ListingIntField(controller: draft.acikAlanCtrl, label: 'Açık Alan (m²)', hint: 'Örn: 300', required: false),
          ListingIntField(controller: draft.kapaliAlanCtrl, label: 'Kapalı Alan (m²)', hint: 'Örn: 650', required: false),
          ListingNullableBoolDropdown(
            label: 'Zemin etüdü',
            value: draft.zeminEtudu,
            onChanged: draft.setZeminEtudu,
          ),
          ListingNullableStringDropdown(
            label: 'Yapı durumu',
            value: draft.yapiDurumu,
            items: const ['Sıfır', 'İkinci El', 'Yapım Aşamasında', 'Ruhsatlı'],
            onChanged: draft.setYapiDurumu,
          ),
        ],
      ),
    );
  }
}
