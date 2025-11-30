import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';

class EmlakKonutSection extends StatelessWidget {
  const EmlakKonutSection({super.key, required this.draft});

  final ListingDetailsDraft draft;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return ListingSection(
          title: 'Konut Detayları',
          child: ListingFormGrid(
            children: [
              ListingIntField(
                controller: draft.banyoSayisiCtrl,
                label: 'Banyo Sayısı *',
                hint: 'Örn: 2',
                required: true,
              ),
              ListingStringDropdown(
                label: 'Mutfak Tipi *',
                value: draft.mutfakTipi,
                items: const ['Kapalı', 'Açık', 'Amerikan', 'Belirtilmemiş'],
                onChanged: draft.setMutfakTipi,
              ),
              ListingSwitchTile(label: 'Balkon', value: draft.balkon, onChanged: draft.setBalkon),
              ListingSwitchTile(label: 'Asansör', value: draft.asansor, onChanged: draft.setAsansor),
              ListingSwitchTile(label: 'Eşyalı', value: draft.esyali, onChanged: draft.setEsyali),
              ListingStringDropdown(
                label: 'Kullanım Durumu *',
                value: draft.kullanimDurumu,
                items: const ['Boş', 'Kiracı Oturuyor', 'Mal Sahibi Oturuyor', 'Belirtilmemiş'],
                onChanged: draft.setKullanimDurumu,
              ),
              ListingSwitchTile(
                label: 'Site içinde',
                value: draft.siteIcinde,
                onChanged: draft.setSiteIcinde,
              ),
              if (draft.siteIcinde) ...[
                ListingTextField(
                  controller: draft.siteAdiCtrl,
                  label: 'Site Adı *',
                  hint: 'Örn: Güneş Sitesi',
                  required: true,
                  maxLength: 100,
                ),
                ListingIntField(
                  controller: draft.aidatCtrl,
                  label: 'Aidat *',
                  hint: 'Örn: 750',
                  required: true,
                ),
              ] else ...[
                const ListingHelperInfo(
                  text: 'Site içinde değilse site adı ve aidat alanları gizlenir.',
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
