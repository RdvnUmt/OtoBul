import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'listing_create_models.dart';

class ListingAddressSection extends StatelessWidget {
  const ListingAddressSection({
    super.key,
    required this.mainCategory,
  });

  final ListingMainCategory mainCategory;

  @override
  Widget build(BuildContext context) {
    return mainCategory == ListingMainCategory.emlak
        ? const _EmlakAddressForm()
        : const _VasitaAddressForm();
  }
}

class _VasitaAddressForm extends StatefulWidget {
  const _VasitaAddressForm();

  @override
  State<_VasitaAddressForm> createState() => _VasitaAddressFormState();
}

class _VasitaAddressFormState extends State<_VasitaAddressForm> {
  String _country = 'TR';
  final _ilCtrl = TextEditingController();
  final _ilceCtrl = TextEditingController();

  @override
  void dispose() {
    _ilCtrl.dispose();
    _ilceCtrl.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Adres', style: theme.textTheme.titleLarge),
                const SizedBox(width: 8),
                Text('*', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
                const Spacer(),
                Text(
                  'Vasıta: Ülke / İl / İlçe',
                  style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _country,
              items: const [
                DropdownMenuItem(value: 'TR', child: Text('(TR) Türkiye')),
                DropdownMenuItem(value: 'DE', child: Text('(DE) Almanya')),
                DropdownMenuItem(value: 'NL', child: Text('(NL) Hollanda')),
              ],
              onChanged: (v) => setState(() => _country = v ?? 'TR'),
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
                    controller: _ilCtrl,
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
                    controller: _ilceCtrl,
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
  }
}

class _EmlakAddressForm extends StatefulWidget {
  const _EmlakAddressForm();

  @override
  State<_EmlakAddressForm> createState() => _EmlakAddressFormState();
}

class _EmlakAddressFormState extends State<_EmlakAddressForm> {
  static final _digitsOnly = <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];

  String _country = 'TR';

  final _ilCtrl = TextEditingController();
  final _ilceCtrl = TextEditingController();
  final _semtCtrl = TextEditingController();
  final _mahalleCtrl = TextEditingController();
  final _caddeCtrl = TextEditingController();

  final _binaNoCtrl = TextEditingController();
  final _daireNoCtrl = TextEditingController();
  final _postaKoduCtrl = TextEditingController();

  final _acikAdresCtrl = TextEditingController();
  final _tarifCtrl = TextEditingController();

  @override
  void dispose() {
    _ilCtrl.dispose();
    _ilceCtrl.dispose();
    _semtCtrl.dispose();
    _mahalleCtrl.dispose();
    _caddeCtrl.dispose();
    _binaNoCtrl.dispose();
    _daireNoCtrl.dispose();
    _postaKoduCtrl.dispose();
    _acikAdresCtrl.dispose();
    _tarifCtrl.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Adres', style: theme.textTheme.titleMedium),
                const SizedBox(width: 8),
                Text('*', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
                const Spacer(),
                Text(
                  'Emlak: Detaylı adres',
                  style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _country,
              items: const [
                DropdownMenuItem(value: 'TR', child: Text('(TR) Türkiye')),
                DropdownMenuItem(value: 'DE', child: Text('(DE) Almanya')),
                DropdownMenuItem(value: 'NL', child: Text('(NL) Hollanda')),
              ],
              onChanged: (v) => setState(() => _country = v ?? 'TR'),
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
                    controller: _ilCtrl,
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
                    controller: _ilceCtrl,
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

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _semtCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Semt *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _mahalleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Mahalle *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _caddeCtrl,
              decoration: const InputDecoration(
                labelText: 'Cadde / Sokak *',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _binaNoCtrl,
                    inputFormatters: _digitsOnly,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Bina No *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _daireNoCtrl,
                    inputFormatters: _digitsOnly,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Daire No *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _postaKoduCtrl,
                    inputFormatters: _digitsOnly,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Posta Kodu *',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _acikAdresCtrl,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Açık Adres *',
                border: OutlineInputBorder(),
                isDense: true,
                hintText: 'Örn: X Mah., Y Sk., No:12 D:8, İlçe/İl',
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _tarifCtrl,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Adres Tarifi (Opsiyonel)',
                border: OutlineInputBorder(),
                isDense: true,
                hintText: 'Örn: Metro çıkışı 200m, marketin yanı...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
