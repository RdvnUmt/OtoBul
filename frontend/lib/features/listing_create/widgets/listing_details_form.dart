import 'package:flutter/material.dart';

import 'listing_create_models.dart';
import 'listing_details/listing_details_draft.dart';
import 'listing_details/sections/emlak/emlak_section.dart';
import 'listing_details/sections/general_section.dart';
import 'listing_details/sections/vasita/vasita_section.dart';

class ListingDetailsForm extends StatefulWidget {
  const ListingDetailsForm({
    super.key,
    required this.mainCategory,
    required this.vasitaCategory,
    required this.emlakCategory,
    required this.titleController,
  });

  final ListingMainCategory mainCategory;
  final ListingVasitaCategory vasitaCategory;
  final ListingEmlakCategory emlakCategory;
  final TextEditingController titleController;

  @override
  State<ListingDetailsForm> createState() => _ListingDetailsFormState();
}

class _ListingDetailsFormState extends State<ListingDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late final ListingDetailsDraft draft;

  @override
  void initState() {
    super.initState();
    draft = ListingDetailsDraft();
  }

  @override
  void dispose() {
    draft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('İlan Bilgileri', style: theme.textTheme.titleLarge),
                  const SizedBox(width: 8),
                  Text('*', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
                ],
              ),
              const SizedBox(height: 12),

              GeneralSection(
                draft: draft,
                titleController: widget.titleController,
              ),

              const SizedBox(height: 14),

              if (widget.mainCategory == ListingMainCategory.emlak)
                EmlakSection(
                  draft: draft,
                  emlakCategory: widget.emlakCategory,
                )
              else
                VasitaSection(
                  draft: draft,
                  vasitaCategory: widget.vasitaCategory,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
