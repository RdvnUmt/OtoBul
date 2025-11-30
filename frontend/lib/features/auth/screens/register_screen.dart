import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';
import '/app/app_router.dart';
import '../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
 
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AuthCard(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(
                title: 'Hesap Oluştur'
              ),
              const SizedBox(height: 32),

              // Name & Surname
              Row(
                children: [
                  Expanded(
                    child: AuthTextField(
                      controller: _nameController,
                      label: 'Ad',
                      hint: 'Adınız',
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AuthTextField(
                      controller: _surnameController,
                      label: 'Soyad',
                      hint: 'Soyadınız',
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Email
              AuthTextField(
                controller: _emailController,
                label: 'E-posta Adresi',
                hint: 'otobul@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Phone
              AuthTextField(
                controller: _phoneController,
                label: 'Telefon Numarası',
                hint: '(5XX) XXX XX XX',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // Password
              AuthTextField(
                controller: _passwordController,
                label: 'Şifre',
                hint: 'En az 4 karakter',
                prefixIcon: Icons.lock_outline,
                obscureText: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                  onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),
              
              const SizedBox(height: 24),

              // Register Button
              AuthPrimaryButton(
                text: 'Hesap Oluştur',
                onPressed: () => context.go(AppRoutes.home),
              ),
              const SizedBox(height: 20),

              // Divider
              const AuthDivider(),
              
              const SizedBox(height: 24),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Zaten hesabınız var mı? ',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AuthTextLink(
                    text: 'Giriş Yap',
                    onTap: () => context.go(AppRoutes.login),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

