import 'package:flutter/material.dart';

import '../../listing_form_fields.dart';
import '../listing_details_draft.dart';
import '../listing_details_types.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({
    super.key,
    required this.draft,
    required this.titleController,
  });

  final ListingDetailsDraft draft;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return ListingSection(
          title: 'Genel',
          child: ListingFormGrid(
            children: [
              ListingTextField(
                controller: titleController,
                label: 'İlan Başlığı *',
                hint: 'Örn: Sahibinden, masrafsız',
                maxLength: 50,
                required: true,
              ),
              ListingDecimalField(
                controller: draft.priceCtrl,
                label: 'Fiyat *',
                hint: 'Örn: 250000',
                required: true,
              ),
              ListingEnumDropdown<IlanTipi>(
                label: 'İlan Tipi *',
                value: draft.ilanTipi,
                items: IlanTipi.values,
                labelOf: (e) => e.label,
                onChanged: draft.setIlanTipi,
              ),
              ListingEnumDropdown<KimdenTipi>(
                label: 'Kimden *',
                value: draft.kimden,
                items: KimdenTipi.values,
                labelOf: (e) => e.label,
                onChanged: draft.setKimden,
              ),
              ListingSwitchTile(
                label: 'Krediye uygun',
                value: draft.kredi,
                onChanged: draft.setKredi,
              ),
              ListingSwitchTile(
                label: 'Takas olur',
                value: draft.takas,
                onChanged: draft.setTakas,
              ),
            ],
          ),
        );
      },
    );
  }
}
