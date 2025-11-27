import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Üst Kısım: Linkler
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo ve Açıklama
                Expanded(flex: 2, child: _buildBrandSection()),

                const SizedBox(width: 48),

                // Kurumsal
                Expanded(
                  child: _buildLinkSection(
                    title: 'Kurumsal',
                    links: [
                      _FooterLink(title: 'Hakkımızda', onTap: () {}),
                      _FooterLink(title: 'Kariyer', onTap: () {}),
                      _FooterLink(title: 'Blog', onTap: () {}),
                    ],
                  ),
                ),

                // Destek
                Expanded(
                  child: _buildLinkSection(
                    title: 'Destek',
                    links: [
                      _FooterLink(title: 'Yardım Merkezi', onTap: () {}),
                      _FooterLink(title: 'İletişim', onTap: () {}),
                      _FooterLink(title: 'SSS', onTap: () {}),
                    ],
                  ),
                ),

                // Yasal
                Expanded(
                  child: _buildLinkSection(
                    title: 'Yasal',
                    links: [
                      _FooterLink(title: 'Kullanım Koşulları', onTap: () {}),
                      _FooterLink(title: 'Gizlilik Politikası', onTap: () {}),
                      _FooterLink(title: 'KVKK', onTap: () {}),
                    ],
                  ),
                ),

                // İletişim
                Expanded(child: _buildContactSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.directions_car_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'OTO',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 1,
                    ),
                  ),
                  TextSpan(
                    text: 'BUL',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Türkiye\'nin güvenilir emlak ve vasıta ilan platformu. ',
          style: GoogleFonts.inter(
            fontSize: 13,
            height: 1.6,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '© 2025 OtoBul. Tüm hakları saklıdır.',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textTertiary),
        ),
      ],
    );
  }

  Widget _buildLinkSection({
    required String title,
    required List<_FooterLink> links,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _FooterLinkWidget(link: link),
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _ContactItem(icon: Icons.email_outlined, text: 'info@otobul.com'),
        const SizedBox(height: 10),
        _ContactItem(icon: Icons.phone_outlined, text: '+90 (555) 555 55 55'),
        const SizedBox(height: 10),
        _ContactItem(icon: Icons.location_on_outlined, text: 'Ankara, Türkiye'),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER LİNK MODELİ
// ═══════════════════════════════════════════════════════════════════════════════
class _FooterLink {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({required this.title, required this.onTap});
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER LİNK WIDGET'I
// ═══════════════════════════════════════════════════════════════════════════════
class _FooterLinkWidget extends StatefulWidget {
  final _FooterLink link;

  const _FooterLinkWidget({required this.link});

  @override
  State<_FooterLinkWidget> createState() => _FooterLinkWidgetState();
}

class _FooterLinkWidgetState extends State<_FooterLinkWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.link.onTap,
        child: Text(
          widget.link.title,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// İLETİŞİM ITEM WIDGET'I
// ═══════════════════════════════════════════════════════════════════════════════
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SOSYAL MEDYA İKON WIDGET'I
// ═══════════════════════════════════════════════════════════════════════════════
class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _isHovered ? AppColors.borderLight : AppColors.border,
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 16,
              color: _isHovered
                  ? AppColors.textPrimary
                  : AppColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
