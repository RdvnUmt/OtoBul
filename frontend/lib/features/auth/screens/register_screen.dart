import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';
import '/app/app_router.dart';
import '/core/services/auth_service.dart';
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
  final _authService = AuthService();

  bool _passwordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
 
  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Validasyon
    if (_nameController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Ad gerekli');
      return;
    }
    if (_surnameController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Soyad gerekli');
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'E-posta adresi gerekli');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Telefon numarası gerekli');
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Şifre gerekli');
      return;
    }
    if (_passwordController.text.length < 4) {
      setState(() => _errorMessage = 'Şifre en az 4 karakter olmalı');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final response = await _authService.signup(
      ad: _nameController.text.trim(),
      soyad: _surnameController.text.trim(),
      email: _emailController.text.trim(),
      telefonNo: _phoneController.text.trim(),
      sifre: _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (response.success) {
      setState(() => _successMessage = response.message);
      
      // 2 saniye sonra login sayfasına yönlendir
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go(AppRoutes.login);
      }
    } else {
      setState(() => _errorMessage = response.message);
    }
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

              // Success Message
              if (_successMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _successMessage!,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Error Message
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

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
                hint: '05XX XXX XX XX',
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
                text: _isLoading ? 'Kayıt yapılıyor...' : 'Hesap Oluştur',
                onPressed: _isLoading ? null : _handleRegister,
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

