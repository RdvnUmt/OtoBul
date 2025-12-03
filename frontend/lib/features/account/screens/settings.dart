import 'package:flutter/material.dart';

import '/core/services/auth_service.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.initialPhone, this.initialEmail});

  final String? initialPhone;
  final String? initialEmail;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Profile/Favorites ile uyumlu renkler
  static const _primary = Color(0xFF2060E0);
  static const _ink = Color(0xFF102030);

  final AuthService _authService = AuthService();

  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _newPasswordAgainController;

  late final TextEditingController _deleteAccountPasswordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone ?? "");
    _emailController = TextEditingController(text: widget.initialEmail ?? "");

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordAgainController = TextEditingController();

    _deleteAccountPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();
    _deleteAccountPasswordController.dispose();
    super.dispose();
  }

  // BUTON FONKSİYONLARI (bilerek boş)
  void _savePhone() async {
    final newPhone = _phoneController.text.trim();
    if (newPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Telefon numarası boş olamaz.')),
      );
      return;
    }

    final ok = await _authService.updatePhone(newPhone);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Telefon numarası güncellendi.' : 'Telefon numarası güncellenemedi.'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  void _revertPhone() {
    _phoneController.text = widget.initialPhone ?? '';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Telefon numarası eski haline getirildi.')),
    );
  }

  void _saveEmail() async {
    final newEmail = _emailController.text.trim();
    if (newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-posta boş olamaz.')),
      );
      return;
    }

    final ok = await _authService.updateEmail(newEmail);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'E-posta adresi güncellendi.' : 'E-posta adresi güncellenemedi.'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  void _revertEmail() {
    _emailController.text = widget.initialEmail ?? '';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E-posta adresi eski haline getirildi.')),
    );
  }

  void _savePassword() async {
    final current = _currentPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();
    final newAgain = _newPasswordAgainController.text.trim();

    if (current.isEmpty || newPass.isEmpty || newAgain.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tüm şifre alanlarını doldurun.')),
      );
      return;
    }

    if (newPass != newAgain) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yeni şifreler uyuşmuyor.'), backgroundColor: Colors.red),
      );
      return;
    }

    final user = _authService.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifre değiştirmek için lütfen giriş yapın.')),
      );
      return;
    }

    // Mevcut şifreyi doğrula
    final loginResp = await _authService.login(user.email, current);
    if (!loginResp.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mevcut şifre hatalı.'), backgroundColor: Colors.red),
      );
      return;
    }

    final ok = await _authService.updatePassword(newPass);
    if (ok) {
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _newPasswordAgainController.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Şifre güncellendi.' : 'Şifre güncellenemedi.'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  void _revertPassword() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordAgainController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Şifre alanları temizlendi.')),
    );
  }

  void _saveDeleteAccount() async {
    final password = _deleteAccountPasswordController.text.trim();
    final user = _authService.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hesap silmek için lütfen giriş yapın.')),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen şifrenizi girin.')),
      );
      return;
    }

    // Şifre doğrulama
    final loginResp = await _authService.login(user.email, password);
    if (!loginResp.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifre hatalı.'), backgroundColor: Colors.red),
      );
      return;
    }

    final ok = await _authService.deleteCurrentUser();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Hesabınız silindi.' : 'Hesap silinemedi.'),
        backgroundColor: ok ? Colors.red : Colors.orange,
      ),
    );
  }

  void _revertDeleteAccount() {
    _deleteAccountPasswordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('İşlem iptal edildi.')), 
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ AccountShell zaten Scaffold + scroll sağlıyor
    // ✅ Burada sadece içerik döndürüyoruz (ProfilePage mantığı)
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PageHeader(
                  title: 'Ayarlar',
                  subtitle: 'Hesap ve güvenlik seçenekleri',
                  icon: Icons.settings_rounded,
                  iconColor: _primary,
                  titleColor: _ink,
                ),
                const SizedBox(height: 14),

                _SectionAccordion(
                  title: "Telefon değişikliği",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const _HelperText(
                        "Telefon numaranız, belirli durumlarda diğer kullanıcılar tarafından görüntülenebilir.",
                      ),
                      const SizedBox(height: 12),
                      _SettingFieldRow(
                        leadingIcon: Icons.phone,
                        controller: _phoneController,
                        hintText: "Yeni telefon numarası",
                        keyboardType: TextInputType.phone,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 14),
                      _SaveRevertRow(onSave: _savePhone, onRevert: _revertPhone, primary: _primary, ink: _ink),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                _SectionAccordion(
                  title: "E-posta değişikliği",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const _HelperText(
                        "E-posta adresiniz hesap bildirimleri ve oturum işlemlerinde kullanılır.",
                      ),
                      const SizedBox(height: 12),
                      _SettingFieldRow(
                        leadingIcon: Icons.email_outlined,
                        controller: _emailController,
                        hintText: "Yeni e-posta adresi",
                        keyboardType: TextInputType.emailAddress,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 14),
                      _SaveRevertRow(onSave: _saveEmail, onRevert: _revertEmail, primary: _primary, ink: _ink),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                _SectionAccordion(
                  title: "Şifre değişikliği",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const _HelperText(
                        "Güvenlik için şifrenizi düzenli aralıklarla güncellemeniz önerilir.",
                      ),
                      const SizedBox(height: 12),
                      _SettingFieldRow(
                        leadingIcon: Icons.lock_outline,
                        controller: _currentPasswordController,
                        hintText: "Mevcut şifre",
                        obscureText: true,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 10),
                      _SettingFieldRow(
                        leadingIcon: Icons.lock_reset_outlined,
                        controller: _newPasswordController,
                        hintText: "Yeni şifre",
                        obscureText: true,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 10),
                      _SettingFieldRow(
                        leadingIcon: Icons.lock_reset_outlined,
                        controller: _newPasswordAgainController,
                        hintText: "Yeni şifre (tekrar)",
                        obscureText: true,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 14),
                      _SaveRevertRow(onSave: _savePassword, onRevert: _revertPassword, primary: _primary, ink: _ink),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                _SectionAccordion(
                  title: "Hesap silme",
                  headerIcon: Icons.warning_amber_rounded,
                  headerIconColor: const Color(0xFFD32F2F),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const _DangerBox(
                        text:
                            "Hesabınızı sildiğinizde verileriniz geri alınamayabilir. Lütfen devam etmeden önce emin olun.",
                      ),
                      const SizedBox(height: 12),
                      _SettingFieldRow(
                        leadingIcon: Icons.key_outlined,
                        controller: _deleteAccountPasswordController,
                        hintText: "Onay için şifre",
                        obscureText: true,
                        primary: _primary,
                        ink: _ink,
                      ),
                      const SizedBox(height: 14),
                      _SaveRevertRow(
                        onSave: _saveDeleteAccount,
                        onRevert: _revertDeleteAccount,
                        primary: const Color(0xFFD32F2F),
                        ink: _ink,
                        saveText: "Hesabı Sil",
                        revertText: "Vazgeç",
                        danger: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.titleColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7EAF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: titleColor.withOpacity(.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionAccordion extends StatefulWidget {
  const _SectionAccordion({
    required this.title,
    required this.child,
    this.headerIcon,
    this.headerIconColor,
  });

  final String title;
  final Widget child;
  final IconData? headerIcon;
  final Color? headerIconColor;

  @override
  State<_SectionAccordion> createState() => _SectionAccordionState();
}

class _SectionAccordionState extends State<_SectionAccordion> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            maintainState: true,
            initiallyExpanded: _expanded,
            onExpansionChanged: (v) => setState(() => _expanded = v),
            tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                if (widget.headerIcon != null) ...[
                  Icon(widget.headerIcon, color: widget.headerIconColor),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF102030),
                    ),
                  ),
                ),
              ],
            ),
            children: [widget.child],
          ),
        ),
      ),
    );
  }
}

class _SettingFieldRow extends StatelessWidget {
  const _SettingFieldRow({
    required this.leadingIcon,
    required this.controller,
    required this.hintText,
    required this.primary,
    required this.ink,
    this.keyboardType,
    this.obscureText = false,
  });

  final IconData leadingIcon;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color primary;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EAF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(leadingIcon, color: primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: TextStyle(color: ink, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(color: ink.withOpacity(.45)),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_outlined, color: primary),
            tooltip: "Düzenle",
          ),
        ],
      ),
    );
  }
}

class _SaveRevertRow extends StatelessWidget {
  const _SaveRevertRow({
    required this.onSave,
    required this.onRevert,
    required this.primary,
    required this.ink,
    this.saveText = "Kaydet",
    this.revertText = "Geri Al",
    this.danger = false,
  });

  final VoidCallback onSave;
  final VoidCallback onRevert;
  final String saveText;
  final String revertText;
  final Color primary;
  final Color ink;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: onSave,
            child: Text(saveText, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: danger ? primary : ink,
              side: const BorderSide(color: Color(0xFFE7EAF2)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: onRevert,
            child: Text(revertText, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF102030).withOpacity(.65),
        height: 1.35,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _DangerBox extends StatelessWidget {
  const _DangerBox({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    const danger = Color(0xFFD32F2F);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: danger.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: danger.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: danger),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF102030).withOpacity(.85),
                height: 1.35,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
