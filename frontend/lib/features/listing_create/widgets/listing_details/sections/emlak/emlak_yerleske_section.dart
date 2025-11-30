import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';

class EmlakYerleskeSection extends StatelessWidget {
  const EmlakYerleskeSection({super.key, required this.draft});

  final ListingDetailsDraft draft;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Bina / Yerleşke',
      child: ListingFormGrid(
        children: [
          ListingStringDropdown(
            label: 'Oda Sayısı *',
            value: draft.odaSayisi,
            items: const ['1+0', '1+1', '2+1', '3+1', '4+1', '5+1', '6+ ve üzeri'],
            onChanged: draft.setOdaSayisi,
          ),
          ListingIntField(
            controller: draft.binaYasiCtrl,
            label: 'Bina Yaşı *',
            hint: 'Örn: 8',
            required: true,
          ),
          ListingIntField(
            controller: draft.bulunduguKatCtrl,
            label: 'Bulunduğu Kat *',
            hint: 'Örn: 3',
            required: true,
          ),
          ListingIntField(
            controller: draft.katSayisiCtrl,
            label: 'Kat Sayısı *',
            hint: 'Örn: 10',
            required: true,
          ),
          ListingStringDropdown(
            label: 'Isıtma *',
            value: draft.isitma,
            items: const ['Doğalgaz', 'Kombi', 'Merkezi', 'Soba', 'Klima', 'Yerden Isıtma', 'Belirtilmemiş'],
            onChanged: draft.setIsitma,
          ),
          ListingSwitchTile(
            label: 'Otopark var',
            value: draft.otopark,
            onChanged: draft.setOtopark,
          ),
        ],
      ),
    );
  }
}
