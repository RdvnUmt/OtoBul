import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';
import '../../listing_details_types.dart';

class VasitaTirSection extends StatelessWidget {
  const VasitaTirSection({
    super.key,
    required this.draft,
    required this.kabinTipleri,
  });

  final ListingDetailsDraft draft;
  final List<LabeledInt> kabinTipleri;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Tır Detayları',
      child: ListingFormGrid(
        children: [
          ListingIntDropdown(
            label: 'Kabin *',
            value: draft.kabin,
            items: kabinTipleri,
            onChanged: draft.setKabin,
          ),
          ListingIntField(
            controller: draft.lastikYuzdeCtrl,
            label: 'Lastik Durumu (%) *',
            hint: 'Örn: 80',
            required: true,
            validator: (v) {
              final msg = listingRequiredText(v, 'Lastik durumu zorunlu');
              if (msg != null) return msg;
              final n = int.tryParse(v!.trim());
              if (n == null) return 'Sayı olmalı';
              if (n < 0 || n > 100) return '0-100 arası olmalı';
              return null;
            },
          ),
          ListingIntField(
            controller: draft.yatakSayisiTirCtrl,
            label: 'Yatak Sayısı *',
            hint: 'Örn: 2',
            required: true,
          ),
          ListingSwitchTile(
            label: 'Dorseli',
            value: draft.dorse,
            onChanged: draft.setDorse,
          ),
        ],
      ),
    );
  }
}
