import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onPostAdTap;

  const AppHeader({
    super.key,
    this.onLogoTap,
    this.onLoginTap,
    this.onRegisterTap,
    this.onProfileTap,
    this.onPostAdTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(decoration: TextDecoration.none),
      child: Container(
        height: 72,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.surface,
              Color.fromARGB(255, 39, 65, 105),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border(
            bottom: BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onLogoTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.directions_car_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'OTO',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  TextSpan(
                    text: 'BUL',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LoginButton(onTap: onLoginTap),
        const SizedBox(width: 12),
        _RegisterButton(onTap: onRegisterTap),
        const SizedBox(width: 12),
        _ProfileButton(onTap: onProfileTap),
        const SizedBox(width: 12),
        _PostAdButton(onTap: onPostAdTap),
      ],
    );
  }
}

class _LoginButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _LoginButton({this.onTap});

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
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
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _isHovered ? AppColors.borderLight : AppColors.border,
              width: 1,
            ),
          ),
          child: Text(
            'Giriş Yap',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
              letterSpacing: 0.2,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _RegisterButton({this.onTap});

  @override
  State<_RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<_RegisterButton> {
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
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primaryLight : AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Hesap Oluştur',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.2,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _ProfileButton({this.onTap});

  @override
  State<_ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<_ProfileButton> {
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
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceLight : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _isHovered ? AppColors.borderLight : AppColors.border,
              width: 1,
            ),
          ),
          child: Text(
            'Profilim',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
              letterSpacing: 0.2,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _PostAdButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _PostAdButton({this.onTap});

  @override
  State<_PostAdButton> createState() => _PostAdButtonState();
}

class _PostAdButtonState extends State<_PostAdButton> {
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
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primaryLight : AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'İlan Ver',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.2,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
