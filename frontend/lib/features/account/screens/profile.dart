import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/address_service.dart';
import '../../../core/models/address_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.initialFirstName = '',
    this.initialLastName = '',
    this.phone = '',
    this.email = '',
  });

  final String initialFirstName;
  final String initialLastName;
  final String phone;
  final String email;

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
  late final TextEditingController _ulkeC;
  late final TextEditingController _sehirC;
  late final TextEditingController _ilceC;

  // Initial değerler
  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialUlke = '';
  String _initialSehir = '';
  String _initialIlce = '';

  Address? _currentAddress;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _firstNameC = TextEditingController(text: widget.initialFirstName);
    _lastNameC = TextEditingController(text: widget.initialLastName);
    _ulkeC = TextEditingController();
    _sehirC = TextEditingController();
    _ilceC = TextEditingController();

    _initialFirstName = widget.initialFirstName;
    _initialLastName = widget.initialLastName;

    _loadAddressData();
  }

  @override
  void dispose() {
    _firstNameC.dispose();
    _lastNameC.dispose();
    _ulkeC.dispose();
    _sehirC.dispose();
    _ilceC.dispose();
    super.dispose();
  }

  /// Kullanıcının adres bilgilerini yükle
  Future<void> _loadAddressData() async {
    setState(() => _isLoading = true);

    try {
      final user = AuthService().currentUser;
      if (user?.adresId != null) {
        final address = await AddressService().getAddressById(user!.adresId!);
        if (address != null) {
          _currentAddress = address;
          _ulkeC.text = address.ulke ?? '';
          _sehirC.text = address.sehir ?? '';
          _ilceC.text = address.ilce ?? '';

          _initialUlke = address.ulke ?? '';
          _initialSehir = address.sehir ?? '';
          _initialIlce = address.ilce ?? '';
        }
      }
    } catch (e) {
      debugPrint('❌ Adres yükleme hatası: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Değişiklikleri kaydet
  Future<void> saveChanges() async {
    FocusScope.of(context).unfocus();

    if (!_hasAnyEdits) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Değişiklik yapılmadı')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final user = AuthService().currentUser;
      if (user == null) {
        throw Exception('Kullanıcı bulunamadı');
      }

      // 1. Ad ve Soyad güncelleme
      final nameChanged = _firstNameC.text.trim() != _initialFirstName ||
          _lastNameC.text.trim() != _initialLastName;

      if (nameChanged) {
        final success = await AuthService().updateUserFields({
          'ad': _firstNameC.text.trim(),
          'soyad': _lastNameC.text.trim(),
        });

        if (!success) {
          throw Exception('Kullanıcı bilgileri güncellenemedi');
        }
      }

      // 2. Adres işlemleri
      final addressChanged = _ulkeC.text.trim() != _initialUlke ||
          _sehirC.text.trim() != _initialSehir ||
          _ilceC.text.trim() != _initialIlce;

      if (addressChanged) {
        final hasAddressData = _ulkeC.text.trim().isNotEmpty ||
            _sehirC.text.trim().isNotEmpty ||
            _ilceC.text.trim().isNotEmpty;

        if (hasAddressData) {
          int? newAddressId;

          if (_currentAddress == null || user.adresId == null) {
            // Yeni adres ekle
            final newAddress = Address(
              ulke: _ulkeC.text.trim().isNotEmpty ? _ulkeC.text.trim() : null,
              sehir: _sehirC.text.trim().isNotEmpty ? _sehirC.text.trim() : null,
              ilce: _ilceC.text.trim().isNotEmpty ? _ilceC.text.trim() : null,
            );

            newAddressId = await AddressService().addAddress(newAddress);

            if (newAddressId == null) {
              throw Exception('Adres eklenemedi');
            }

            debugPrint('✅ Yeni adres eklendi: $newAddressId');
          } else {
            // Mevcut adresi güncelle
            final updatedAddress = Address(
              adresId: _currentAddress!.adresId, // ✅ Önemli: adres_id'yi koru
              ulke: _ulkeC.text.trim().isNotEmpty ? _ulkeC.text.trim() : null,
              sehir: _sehirC.text.trim().isNotEmpty ? _sehirC.text.trim() : null,
              ilce: _ilceC.text.trim().isNotEmpty ? _ilceC.text.trim() : null,
              // Diğer alanları mevcut değerlerden al
              mahalle: _currentAddress!.mahalle,
              cadde: _currentAddress!.cadde,
              sokak: _currentAddress!.sokak,
              binaNo: _currentAddress!.binaNo,
              daireNo: _currentAddress!.daireNo,
              postaKodu: _currentAddress!.postaKodu,
            );

            final success = await AddressService().updateAddress(updatedAddress);

            if (!success) {
              throw Exception('Adres güncellenemedi');
            }

            debugPrint('✅ Adres güncellendi: ${_currentAddress!.adresId}');
          }

          // 3. Kullanıcının adres_id'sini güncelle (eğer yeni adres eklendiyse)
          if (newAddressId != null && user.adresId != newAddressId) {
            final success = await AuthService().updateUserFields({
              'adres_id': newAddressId,
            });

            if (!success) {
              throw Exception('Kullanıcı adres ID\'si güncellenemedi');
            }

            debugPrint('✅ Kullanıcının adres_id\'si güncellendi: $newAddressId');
          }
        }
      }

      // Başarılı, initial değerleri güncelle
      _initialFirstName = _firstNameC.text.trim();
      _initialLastName = _lastNameC.text.trim();
      _initialUlke = _ulkeC.text.trim();
      _initialSehir = _sehirC.text.trim();
      _initialIlce = _ilceC.text.trim();

      // Adresi yeniden yükle
      await _loadAddressData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Değişiklikler başarıyla kaydedildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Kaydetme hatası: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  /// Değişiklikleri geri al
  void revertChanges() {
    FocusScope.of(context).unfocus();

    setState(() {
      _firstNameC.text = _initialFirstName;
      _lastNameC.text = _initialLastName;
      _ulkeC.text = _initialUlke;
      _sehirC.text = _initialSehir;
      _ilceC.text = _initialIlce;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Değişiklikler geri alındı')),
    );
  }

  bool get _hasAnyEdits {
    return _firstNameC.text.trim() != _initialFirstName ||
        _lastNameC.text.trim() != _initialLastName ||
        _ulkeC.text.trim() != _initialUlke ||
        _sehirC.text.trim() != _initialSehir ||
        _ilceC.text.trim() != _initialIlce;
  }

  // AYARLARA YÖNLENDİRİLECEKLER
  void editPhone() {
    debugPrint('editPhone clicked - Settings sayfasına yönlendir');
  }

  void editEmail() {
    debugPrint('editEmail clicked - Settings sayfasına yönlendir');
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
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

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

                    TextField(
                      controller: _ulkeC,
                      onChanged: (_) => setState(() {}),
                      decoration: _dec(label: 'Ülke', hint: 'Türkiye'),
                      textInputAction: TextInputAction.next,
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _sehirC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'İl', hint: 'İstanbul'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _ilceC,
                            onChanged: (_) => setState(() {}),
                            decoration: _dec(label: 'İlçe', hint: 'Kadıköy'),
                            textInputAction: TextInputAction.done,
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
                      onPressed: (_hasAnyEdits && !_isSaving) ? revertChanges : null,
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
                      onPressed: (_hasAnyEdits && !_isSaving) ? saveChanges : null,
                      icon: _isSaving 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.check),
                      label: Text(_isSaving ? 'Kaydediliyor...' : 'Değişiklikleri Kaydet'),
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
