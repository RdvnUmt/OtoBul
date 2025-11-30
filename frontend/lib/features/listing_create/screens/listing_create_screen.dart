import 'package:flutter/material.dart';

import '../widgets/category_selection_panel.dart';
import '../widgets/listing_address_section.dart';
import '../widgets/listing_create_models.dart';
import '../widgets/listing_description_editor.dart';
import '../widgets/listing_details_form.dart';

class ListingCreateScreen extends StatefulWidget {
  const ListingCreateScreen({super.key});

  @override
  State<ListingCreateScreen> createState() => _ListingCreateScreenState();
}

class _ListingCreateScreenState extends State<ListingCreateScreen> {
  ListingMainCategory _mainCategory = ListingMainCategory.vasita;
  ListingVasitaCategory _vasitaCategory = ListingVasitaCategory.otomobil;
  ListingEmlakCategory _emlakCategory = ListingEmlakCategory.konut;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String get _selectedCategoryLabel {
    switch (_mainCategory) {
      case ListingMainCategory.emlak:
        return 'Emlak • ${_emlakCategory.label}';
      case ListingMainCategory.vasita:
        return 'Vasıta • ${_vasitaCategory.label}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Sayfanın tamamı için maksimum genişlik
    const double pageMaxWidth = 1100;

    // Kategori paneli için maksimum genişlik (sola yapışık duracak)
    const double categoryMaxWidth = 520;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78,
        centerTitle: false,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yeni İlan',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _selectedCategoryLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Yardım',
            onPressed: () {},
            icon: const Icon(Icons.help_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: pageMaxWidth),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // category panel: max width + sola yapışık
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: categoryMaxWidth),
                        child: CategorySelectionPanel(
                          mainCategory: _mainCategory,
                          vasitaCategory: _vasitaCategory,
                          emlakCategory: _emlakCategory,
                          onChanged: (nextMain, nextVasita, nextEmlak) {
                            setState(() {
                              _mainCategory = nextMain;
                              _vasitaCategory = nextVasita;
                              _emlakCategory = nextEmlak;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ListingDetailsForm(
                      mainCategory: _mainCategory,
                      vasitaCategory: _vasitaCategory,
                      emlakCategory: _emlakCategory,
                      titleController: _titleController,
                    ),
                    const SizedBox(height: 16),

                    ListingDescriptionEditor(
                      controller: _descriptionController,
                    ),
                    const SizedBox(height: 16),

                    ListingAddressSection(
                      mainCategory: _mainCategory,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
