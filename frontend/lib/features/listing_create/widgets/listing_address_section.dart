import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'listing_create_models.dart';
import 'listing_address_draft.dart';
import 'listing_form_fields.dart'; // listingRequiredText için

class ListingAddressSection extends StatelessWidget {
  const ListingAddressSection({
    super.key,
    required this.mainCategory,
    required this.draft,
  });

  final ListingMainCategory mainCategory;
  final ListingAddressDraft draft;

  @override
  Widget build(BuildContext context) {
    return mainCategory == ListingMainCategory.emlak
        ? _EmlakAddressForm(draft: draft)
        : _VasitaAddressForm(draft: draft);
  }
}

class _VasitaAddressForm extends StatelessWidget {
  const _VasitaAddressForm({required this.draft});

  final ListingAddressDraft draft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text('Adres', style: theme.textTheme.titleLarge),
                    const SizedBox(width: 8),
                    Text(
                      '*',
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                    const Spacer(),
                    Text(
                      'Zorunlu: Ülke / İl / İlçe',
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: draft.country,
                  items: const [
                    DropdownMenuItem(value: 'TR', child: Text('(TR) Türkiye')),
                    DropdownMenuItem(value: 'DE', child: Text('(DE) Almanya')),
                    DropdownMenuItem(value: 'NL', child: Text('(NL) Hollanda')),
                  ],
                  onChanged: (v) => draft.setCountry(v ?? 'TR'),
                  decoration: const InputDecoration(
                    labelText: 'Ülke *',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: draft.ilCtrl,
                        validator: (v) => listingRequiredText(v, 'İl zorunlu'),
                        decoration: const InputDecoration(
                          labelText: 'İl *',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: draft.ilceCtrl,
                        validator: (v) => listingRequiredText(v, 'İlçe zorunlu'),
                        decoration: const InputDecoration(
                          labelText: 'İlçe *',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmlakAddressForm extends StatelessWidget {
  const _EmlakAddressForm({required this.draft});

  final ListingAddressDraft draft;

  static final _digitsOnly = <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: draft,
      builder: (_, __) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text('Adres', style: theme.textTheme.titleMedium),
                    const SizedBox(width: 8),
                    Text(
                      '*',
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                    const Spacer(),
                    Text(
                      'Zorunlu: Ülke / İl / İlçe',
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: draft.country,
                  items: const [
                    DropdownMenuItem(value: 'TR', child: Text('(TR) Türkiye')),
                    DropdownMenuItem(value: 'DE', child: Text('(DE) Almanya')),
                    DropdownMenuItem(value: 'NL', child: Text('(NL) Hollanda')),
                  ],
                  onChanged: (v) => draft.setCountry(v ?? 'TR'),
                  decoration: const InputDecoration(
                    labelText: 'Ülke *',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: draft.ilCtrl,
                        validator: (v) => listingRequiredText(v, 'İl zorunlu'),
                        decoration: const InputDecoration(
                          labelText: 'İl *',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: draft.ilceCtrl,
                        validator: (v) => listingRequiredText(v, 'İlçe zorunlu'),
                        decoration: const InputDecoration(
                          labelText: 'İlçe *',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: draft.mahalleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mahalle',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: draft.caddeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Cadde',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: draft.sokakCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Sokak',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: draft.binaNoCtrl,
                        inputFormatters: _digitsOnly,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Bina No',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: draft.daireNoCtrl,
                        inputFormatters: _digitsOnly,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Daire No',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: draft.postaKoduCtrl,
                        inputFormatters: _digitsOnly,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Posta Kodu',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
