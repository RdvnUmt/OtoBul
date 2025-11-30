import 'package:flutter/material.dart';

import '../../../listing_form_fields.dart';
import '../../listing_details_draft.dart';

class EmlakDevreMulkSection extends StatelessWidget {
  const EmlakDevreMulkSection({super.key, required this.draft});

  final ListingDetailsDraft draft;

  @override
  Widget build(BuildContext context) {
    return ListingSection(
      title: 'Devre Mülk Detayları',
      child: ListingFormGrid(
        children: [
          ListingStringDropdown(
            label: 'Dönem *',
            value: draft.devreDonem,
            items: const ['Yaz', 'Kış', 'Bahar', 'Sonbahar', 'Haftalık', 'Aylık'],
            onChanged: draft.setDevreDonem,
          ),
        ],
      ),
    );
  }
}
