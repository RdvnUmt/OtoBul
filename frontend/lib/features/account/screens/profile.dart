import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.initialFirstName = '',
    this.initialLastName = '',
    this.phone = '',
    this.email = '',
    this.initialCountryCode = 'TR',
    this.initialCity = '',
    this.initialDistrict = '',
  });

  final String initialFirstName;
  final String initialLastName;

  final String phone;
  final String email;

  final String initialCountryCode;
  final String initialCity;
  final String initialDistrict;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Logo paletine yakın bir tema
  static const _primary = Color(0xFF2060E0);
  static const _ink = Color(0xFF102030);
  static const _fieldFill = Color(0xFFF6F7FB);
  static const _border = Color(0xFFE7EAF2);

  late final TextEditingController _firstNameC;
  late final TextEditingController _lastNameC;

  late final TextEditingController _cityC;
  late final TextEditingController _districtC;

  late String _countryCode;

  @override
  void initState() {
    super.initState();
    _firstNameC = TextEditingController(text: widget.initialFirstName);
    _lastNameC = TextEditingController(text: widget.initialLastName);

    _countryCode = widget.initialCountryCode;
    _cityC = TextEditingController(text: widget.initialCity);
    _districtC = TextEditingController(text: widget.initialDistrict);
  }

  @override
  void dispose() {
    _firstNameC.dispose();
    _lastNameC.dispose();
    _cityC.dispose();
    _districtC.dispose();
    super.dispose();
  }

  // AYARLARA YÖNLENDİRİLECEKLER
  void editPhone() {
    // TODO: modal aç / dialog / route vs.
    debugPrint('editPhone clicked');
  }

  void editEmail() {
    // TODO: modal aç / dialog / route vs.
    debugPrint('editEmail clicked');
  }

  void saveChanges() { // API
    FocusScope.of(context).unfocus();

    final payload = <String, dynamic>{
      'firstName': _firstNameC.text.trim(),
      'lastName': _lastNameC.text.trim(),
      'countryCode': _countryCode,
      'city': _cityC.text.trim(),
      'district': _districtC.text.trim(),
    };

    debugPrint('SAVE payload: $payload');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Değişiklikler kaydedildi.')),
    );

    // TODO: buradan API çağrısı/DB güncellemesi bağlayacaksın.
  }

  void revertChanges() {  // API
    FocusScope.of(context).unfocus();

    setState(() {
      _firstNameC.text = widget.initialFirstName;
      _lastNameC.text = widget.initialLastName;

      _countryCode = widget.initialCountryCode;
      _cityC.text = widget.initialCity;
      _districtC.text = widget.initialDistrict;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Değişiklikler geri alındı.')),
    );
  }

  bool get _hasAnyEdits {
    return _firstNameC.text.trim() != widget.initialFirstName.trim() ||
        _lastNameC.text.trim() != widget.initialLastName.trim() ||
        _countryCode != widget.initialCountryCode ||
        _cityC.text.trim() != widget.initialCity.trim() ||
        _districtC.text.trim() != widget.initialDistrict.trim();
  }

  String get _initials {
    String pick(String s) {
      final t = s.trim();
      return t.isEmpty ? '' : t.characters.first.toUpperCase();
    }

    final a = pick(_firstNameC.text);
    final b = pick(_lastNameC.text);

    if (a.isEmpty && b.isEmpty) return '?';
    if (b.isEmpty) return a;
    if (a.isEmpty) return b;
    return '$a$b';
    }

  InputDecoration _dec({required String label, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: _fieldFill,
      labelStyle: const TextStyle(color: _ink),
      hintStyle: TextStyle(color: _ink.withOpacity(.45)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primary, width: 1.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Shell zaten Scaffold + scroll sağlıyor; burada sadece içerik var.
    return Container(
      color: Colors.white,
      child: _FixedWidth(
        maxWidth: 560,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header / Avatar
              Row(
                children: [
                  _Avatar(initials: _initials, background: _primary),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profilim',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: _ink,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bilgilerinizi güncelleyin',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: _ink.withOpacity(.65),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionTitle(title: 'Kimlik Bilgileri', color: _ink),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'Ad'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _lastNameC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'Soyad'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionTitle(title: 'İletişim Bilgileri', color: _ink),
                    const SizedBox(height: 10),
                    _InfoRow(
                      label: 'Telefon Numarası',
                      value: widget.phone.isEmpty ? '—' : widget.phone,
                      onEdit: editPhone,
                      ink: _ink,
                      primary: _primary,
                    ),
                    const SizedBox(height: 10),
                    _InfoRow(
                      label: 'E-posta',
                      value: widget.email.isEmpty ? '—' : widget.email,
                      onEdit: editEmail,
                      ink: _ink,
                      primary: _primary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionTitle(title: 'Adres Bilgileri', color: _ink),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: _countryCode,
                      decoration: _dec(label: 'Ülke'),
                      items: const [
                        DropdownMenuItem(value: 'TR', child: Text('(TR) Türkiye')),
                        DropdownMenuItem(value: 'DE', child: Text('(DE) Almanya')),
                        DropdownMenuItem(value: 'NL', child: Text('(NL) Hollanda')),
                        DropdownMenuItem(value: 'FR', child: Text('(FR) Fransa')),
                        DropdownMenuItem(value: 'GB', child: Text('(GB) Birleşik Krallık')),
                        DropdownMenuItem(value: 'US', child: Text('(US) Amerika Birleşik Devletleri')),
                      ],
                      onChanged: (v) => setState(() => _countryCode = v ?? 'TR'),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cityC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'İl'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _districtC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'İlçe'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ✅ Alt aksiyon butonları
              _SectionCard(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _hasAnyEdits ? revertChanges : null,
                      icon: const Icon(Icons.undo),
                      label: const Text('Değişiklikleri Geri Al'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _ink,
                        side: const BorderSide(color: _border),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: _hasAnyEdits ? saveChanges : null,
                      icon: const Icon(Icons.check),
                      label: const Text('Değişiklikleri Kaydet'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FixedWidth extends StatelessWidget {
  const _FixedWidth({required this.child, this.maxWidth = 560});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials, required this.background});
  final String initials;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: .5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.onEdit,
    required this.ink,
    required this.primary,
  });

  final String label;
  final String value;
  final VoidCallback onEdit;
  final Color ink;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EAF2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: ink.withOpacity(.7),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    color: ink,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Düzenle',
            onPressed: onEdit,
            icon: Icon(Icons.edit, color: primary),
          ),
        ],
      ),
    );
  }
}
