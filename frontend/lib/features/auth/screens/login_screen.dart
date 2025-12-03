import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/theme/colors.dart';
import '/app/app_router.dart';
import '/core/services/auth_service.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  
  bool _passwordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validasyon
    if (_emailController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'E-posta adresi gerekli');
      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Şifre gerekli');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (response.success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hoş geldiniz! ${response.user?.fullName ?? ''}'),
            backgroundColor: Colors.green,
          ),
        );
        context.go(AppRoutes.home);
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
                title: 'Giriş Yap'
              ),
              const SizedBox(height: 32),

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

              // Email
              AuthTextField(
                controller: _emailController,
                label: 'E-posta Adresi',
                hint: 'otobul@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password
              AuthTextField(
                controller: _passwordController,
                label: 'Şifre',
                hint: '••••••••',
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
              
              const SizedBox(height: 20),

              // Login Button
              AuthPrimaryButton(
                text: _isLoading ? 'Giriş yapılıyor...' : 'Giriş Yap',
                onPressed: _isLoading ? null : _handleLogin,
              ),
              const SizedBox(height: 20),

              // Divider
              const AuthDivider(),
              const SizedBox(height: 24),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hesabınız yok mu? ',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AuthTextLink(
                    text: 'Hesap Oluştur',
                    onTap: () => context.go(AppRoutes.register),
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

