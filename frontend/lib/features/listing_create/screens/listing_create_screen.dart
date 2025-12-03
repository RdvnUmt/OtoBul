import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/listing_service.dart';
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
        'ulke': _addressDraft.country,
        'sehir': _addressDraft.ilCtrl.text.trim(),
        'ilce': _addressDraft.ilceCtrl.text.trim(),
        'mahalle': _nullIfBlank(_addressDraft.mahalleCtrl.text),
        'cadde': _nullIfBlank(_addressDraft.caddeCtrl.text),
        'sokak': _nullIfBlank(_addressDraft.sokakCtrl.text),
        'bina_no': _intOrNull(_addressDraft.binaNoCtrl.text),
        'daire_no': _intOrNull(_addressDraft.daireNoCtrl.text),
        'posta_kodu': _intOrNull(_addressDraft.postaKoduCtrl.text),
      },
    };
  }

  Map<String, dynamic> _buildKonutPayload() {
    final user = AuthService().currentUser;
    final now = DateTime.now().toIso8601String().replaceAll('T', ' ').substring(0, 19);

    return {
      // Adres
      "ulke": _addressDraft.country,
      "sehir": _addressDraft.ilCtrl.text.trim(),
      "ilce": _addressDraft.ilceCtrl.text.trim(),
      "mahalle": _addressDraft.mahalleCtrl.text.trim(),
      "cadde": _addressDraft.caddeCtrl.text.trim(),
      "sokak": _addressDraft.sokakCtrl.text.trim(),
      "bina_no": _intOrNull(_addressDraft.binaNoCtrl.text),
      "daire_no": _intOrNull(_addressDraft.daireNoCtrl.text),
      "posta_kodu": _addressDraft.postaKoduCtrl.text.trim(),

      // Tarihler
      "olusturulma_tarihi": now,
      "guncellenme_tarihi": now,

      // Kategori & Kullanıcı
      "kategori_ismi": "Konut",
      "kullanici_id": user?.kullaniciId ?? 1,

      // İlan Temel
      "baslik": _titleController.text.trim(),
      "aciklama": _descriptionController.text.trim(),
      "fiyat": _intOrNull(_detailsDraft.priceCtrl.text) ?? 0,
      "ilan_tipi": _detailsDraft.ilanTipi.label,
      "kredi_uygunlugu": _detailsDraft.kredi ? 1 : 0,
      "kimden": _detailsDraft.kimden.label,
      "takas": _detailsDraft.takas ? 1 : 0,

      // Emlak Ortak
      "emlak_tipi": "Konut",
      "m2_brut": _intOrNull(_detailsDraft.m2BrutCtrl.text) ?? 0,
      "m2_net": _intOrNull(_detailsDraft.m2NetCtrl.text) ?? 0,
      "tapu_durumu": _detailsDraft.tapuDurumu,

      // Yerleşke Ortak
      "yerleske_tipi": "Daire", // Varsayılan
      "oda_sayisi": _detailsDraft.odaSayisi,
      "bina_yasi": _intOrNull(_detailsDraft.binaYasiCtrl.text) ?? 0,
      "bulundugu_kat": _intOrNull(_detailsDraft.bulunduguKatCtrl.text) ?? 0,
      "kat_sayisi": _intOrNull(_detailsDraft.katSayisiCtrl.text) ?? 0,
      "isitma": _detailsDraft.isitma,
      "otopark": _detailsDraft.otopark ? 1 : 0,

      // Konut Özel
      "banyo_sayisi": _intOrNull(_detailsDraft.banyoSayisiCtrl.text) ?? 0,
      "mutfak_tipi": _detailsDraft.mutfakTipi,
      "esyali": _detailsDraft.esyali ? 1 : 0,
      "kullanim_durumu": _detailsDraft.kullanimDurumu,
      "balkon": _detailsDraft.balkon ? 1 : 0,
      "asansor": _detailsDraft.asansor ? 1 : 0,
      "site_icinde": _detailsDraft.siteIcinde ? 1 : 0,
      "site_adi": _detailsDraft.siteIcinde ? _detailsDraft.siteAdiCtrl.text.trim() : "",
      "aidat": _detailsDraft.siteIcinde ? (_intOrNull(_detailsDraft.aidatCtrl.text) ?? 0) : 0,
    };
  }

  Future<void> _submit() async {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    // Sadece Konut için backend entegrasyonu yapıldı
    if (_mainCategory == ListingMainCategory.emlak && 
        _emlakCategory == ListingEmlakCategory.konut && 
        !isEditing) {
      
      final payload = _buildKonutPayload();
      
      final success = await ListingService().createKonut(payload);
      
      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Konut ilanı başarıyla oluşturuldu!')),
        );
        context.pop(true); // Başarılı dönüş
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('İlan oluşturulurken bir hata oluştu.')),
        );
      }
      return;
    }

    // Diğer kategoriler için eski mantık (mock)
    final payload = _buildPayload();
    context.pop(payload);
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
