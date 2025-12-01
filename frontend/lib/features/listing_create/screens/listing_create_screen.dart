import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/category_selection_panel.dart';
import '../widgets/listing_address_section.dart';
import '../widgets/listing_address_draft.dart';
import '../widgets/listing_create_models.dart';
import '../widgets/listing_description_editor.dart';
import '../widgets/listing_details_form.dart';
import '../widgets/listing_details/listing_details_draft.dart';
import '../widgets/listing_edit_seed.dart';

class ListingCreateScreen extends StatefulWidget {
  const ListingCreateScreen({super.key, this.initialExtra});

  final Object? initialExtra; // ✅ edit için extra buraya gelir

  @override
  State<ListingCreateScreen> createState() => _ListingCreateScreenState();
}

class _ListingCreateScreenState extends State<ListingCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  ListingMainCategory _mainCategory = ListingMainCategory.vasita;
  ListingVasitaCategory _vasitaCategory = ListingVasitaCategory.otomobil;
  ListingEmlakCategory _emlakCategory = ListingEmlakCategory.konut;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late final ListingDetailsDraft _detailsDraft;
  late final ListingAddressDraft _addressDraft;

  ListingEditSeed? _seed;

  bool get isEditing => _seed != null;

  @override
  void initState() {
    super.initState();
    _detailsDraft = ListingDetailsDraft();
    _addressDraft = ListingAddressDraft();

    _seed = ListingEditSeed.tryParse(widget.initialExtra);

    if (_seed != null) {
      final s = _seed!;
      if (s.mainCategory != null) _mainCategory = s.mainCategory!;
      if (s.vasitaCategory != null) _vasitaCategory = s.vasitaCategory!;
      if (s.emlakCategory != null) _emlakCategory = s.emlakCategory!;

      s.applyTo(
        titleCtrl: _titleController,
        descCtrl: _descriptionController,
        detailsDraft: _detailsDraft,
        addressDraft: _addressDraft,
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _detailsDraft.dispose();
    _addressDraft.dispose();
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

  String? _nullIfBlank(String v) {
    final t = v.trim();
    return t.isEmpty ? null : t;
  }

  int? _intOrNull(String v) {
    final t = v.trim();
    if (t.isEmpty) return null;
    return int.tryParse(t);
  }

  Map<String, dynamic> _buildPayload() {
    return {
      'mode': isEditing ? 'update' : 'create',
      'ilan_id': _seed?.ilanId,
      'category': {
        'main': _mainCategory.name,
        'vasita': _vasitaCategory.name,
        'emlak': _emlakCategory.name,
      },
      'ilan': {
        'baslik': _titleController.text.trim(),
        'aciklama': _descriptionController.text.trim(),
        'fiyat': _detailsDraft.priceCtrl.text.trim(),
        'ilan_tipi': _detailsDraft.ilanTipi.dbValue,
        'kimden': _detailsDraft.kimden.dbValue,
        'kredi_uygunlugu': _detailsDraft.kredi,
        'takas': _detailsDraft.takas,
      },
      'adres': {
        // Zorunlu 3 alan:
        'ulke': _addressDraft.country,
        'sehir': _addressDraft.ilCtrl.text.trim(),
        'ilce': _addressDraft.ilceCtrl.text.trim(),

        // DB alanları (opsiyonel -> boşsa null):
        'mahalle': _nullIfBlank(_addressDraft.mahalleCtrl.text),
        'cadde': _nullIfBlank(_addressDraft.caddeCtrl.text),
        'sokak': _nullIfBlank(_addressDraft.sokakCtrl.text),

        // INT alanlar (opsiyonel -> boşsa null, sayı değilse null):
        'bina_no': _intOrNull(_addressDraft.binaNoCtrl.text),
        'daire_no': _intOrNull(_addressDraft.daireNoCtrl.text),
        'posta_kodu': _intOrNull(_addressDraft.postaKoduCtrl.text),
      },
      // Not: detailsDraft içindeki emlak/vasıta tüm alanlarını da buraya ekleyebilirsin.
      // Şimdilik payload “iskelet”.
    };
  }

  void _submit() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    final payload = _buildPayload();

    // Backend yokken: result olarak geri dön (pop)
    context.pop(payload);
    // Backend bağlayınca burada:
    // if (isEditing) api.updateListing(_seed!.ilanId!, payload);
    // else api.createListing(payload);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double pageMaxWidth = 1100;
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
              isEditing ? 'İlanı Düzenle' : 'Yeni İlan',
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
          TextButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check_rounded),
            label: Text(isEditing ? 'Kaydet' : 'Yayınla'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: pageMaxWidth),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: categoryMaxWidth),
                          child: CategorySelectionPanel(
                            enabled: !isEditing, // ✅ edit’te kategori kilit
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
                        draft: _detailsDraft, // ✅
                      ),
                      const SizedBox(height: 16),

                      ListingDescriptionEditor(controller: _descriptionController),
                      const SizedBox(height: 16),

                      ListingAddressSection(
                        mainCategory: _mainCategory,
                        draft: _addressDraft, // ✅
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
