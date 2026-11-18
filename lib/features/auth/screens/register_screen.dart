import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/customer/home/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/themes/color_constants.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';
import '../widgets/auth_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color muted = Color(0xFF777C75);

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Silakan setujui syarat dan ketentuan terlebih dahulu.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      final cart = context.read<CartProvider>();

      cart.clearCart();

      const product = Product(
        id: 'test-001',
        name: 'Karasko Signature Coffee',
        description: 'Premium coffee for your daily moment.',
        price: 25000,
        category: 'Coffee',
      );

      cart.addItem(product);
      cart.addItem(product);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    });
  }

  Widget _buildBrandHeader(bool compact) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        compact ? 12 : 18,
        24,
        compact ? 30 : 38,
      ),
      decoration: const BoxDecoration(
        color: BaseColor.karasko,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            tooltip: 'Kembali ke login',
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: BaseColor.cream,
              size: 23,
            ),
          ),
          SizedBox(height: compact ? 16 : 24),
          const Text(
            'KARASKO',
            style: TextStyle(
              color: BaseColor.cream,
              fontSize: 19,
              fontWeight: FontWeight.w800,
              letterSpacing: 3.2,
            ),
          ),
          const SizedBox(height: 13),
          Container(width: 34, height: 2, color: BaseColor.caramel),
          const SizedBox(height: 14),
          const Text(
            'COFFEE & DAILY MOMENTS',
            style: TextStyle(
              color: Color(0xFFCED8D0),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),
          SizedBox(height: compact ? 12 : 16),
          Text(
            'Mulai cerita barumu bersama kami.',
            style: TextStyle(
              color: BaseColor.cream,
              fontSize: compact ? 27 : 31,
              height: 1.17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Buat akun Karasko dan nikmati setiap momen kopi favoritmu.',
            style: TextStyle(
              color: Color(0xFFD0D9D2),
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar akun',
          style: TextStyle(
            color: BaseColor.karasko,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Lengkapi informasi berikut untuk memulai.',
          style: TextStyle(color: muted, fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTextField(
              label: 'Nama Lengkap',
              hint: 'Masukkan nama lengkap',
              icon: Icons.person_outline_rounded,
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama lengkap wajib diisi.';
                }

                if (value.trim().length < 3) {
                  return 'Nama minimal 3 karakter.';
                }

                return null;
              },
            ),
            const SizedBox(height: 18),
            AuthTextField(
              label: 'Alamat Email',
              hint: 'nama@email.com',
              icon: Icons.alternate_email_rounded,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: (value) {
                final email = value?.trim() ?? '';

                if (email.isEmpty) {
                  return 'Email wajib diisi.';
                }

                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                  return 'Masukkan alamat email yang valid.';
                }

                return null;
              },
            ),
            const SizedBox(height: 18),
            AuthTextField(
              label: 'Nomor Telepon',
              hint: '08xxxxxxxxxx',
              icon: Icons.phone_outlined,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
            ),
            const SizedBox(height: 18),
            AuthTextField(
              label: 'Kata Sandi',
              hint: 'Minimal 6 karakter',
              icon: Icons.lock_outline_rounded,
              controller: _passwordController,
              isPassword: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kata sandi wajib diisi.';
                }

                if (value.length < 6) {
                  return 'Kata sandi minimal 6 karakter.';
                }

                return null;
              },
            ),
            const SizedBox(height: 18),
            AuthTextField(
              label: 'Konfirmasi Kata Sandi',
              hint: 'Masukkan ulang kata sandi',
              icon: Icons.lock_outline_rounded,
              controller: _confirmPasswordController,
              isPassword: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              onFieldSubmitted: (_) => _handleRegister(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Konfirmasi kata sandi wajib diisi.';
                }

                if (value != _passwordController.text) {
                  return 'Kata sandi tidak sama.';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTermsCheckbox(),
            const SizedBox(height: 24),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return InkWell(
      onTap: () {
        setState(() {
          _agreeToTerms = !_agreeToTerms;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IgnorePointer(
            child: SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _agreeToTerms,
                activeColor: BaseColor.karasko,
                side: const BorderSide(color: Color(0xFFB7BDB4)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (_) {},
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                'Saya menyetujui syarat dan ketentuan serta kebijakan privasi Karasko.',
                style: TextStyle(color: muted, fontSize: 11, height: 1.55),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.karasko,
          foregroundColor: BaseColor.cream,
          disabledBackgroundColor: BaseColor.karasko.withValues(alpha: 0.7),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: BaseColor.cream,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Buat Akun',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, size: 19),
                ],
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'Sudah punya akun?',
          style: TextStyle(color: muted, fontSize: 12),
        ),
        TextButton(
          onPressed: () => Navigator.maybePop(context),
          style: TextButton.styleFrom(
            foregroundColor: BaseColor.caramel,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Masuk di sini',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.cream,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 700;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildBrandHeader(compact),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: compact ? 25 : 32),
                            _buildSectionHeading(),
                            SizedBox(height: compact ? 20 : 26),
                            _buildRegisterForm(),
                            const SizedBox(height: 22),
                            _buildLoginLink(),
                            const SizedBox(height: 24),
                            const Center(
                              child: Text(
                                'KARASKO  •  COFFEE & DAILY MOMENTS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF92978F),
                                  fontSize: 9,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
