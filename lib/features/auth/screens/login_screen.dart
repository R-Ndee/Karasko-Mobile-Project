
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/themes/color_constants.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';
import '../../customer/cart/screens/cart_screen.dart';
import '../widgets/auth_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

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
        MaterialPageRoute(
          builder: (_) => const CartScreen(),
        ),
        (route) => false,
      );
    });
  }

  Widget _buildBrandSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 38, 28, 34),
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
          const Text(
            'KARASKO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w800,
              letterSpacing: 3.2,
            ),
          ),
          const SizedBox(height: 9),
          Container(
            width: 38,
            height: 2,
            color: const Color(0xFFC49A6C),
          ),
          const SizedBox(height: 32),
          const Text(
            'COFFEE & DAILY MOMENTS',
            style: TextStyle(
              color: Color(0xFFC8D2C9),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Selamat datang\nkembali.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              height: 1.15,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Temukan kembali momen kopi favoritmu bersama Karasko.',
            style: TextStyle(
              color: Color(0xFFD0D8D1),
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Masuk ke akun Anda',
            style: TextStyle(
              color: BaseColor.charcoal,
              fontSize: 21,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Masukkan detail akun untuk melanjutkan.',
            style: TextStyle(
              color: Color(0xFF777C75),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 26),
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

              if (!RegExp(
                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
              ).hasMatch(email)) {
                return 'Masukkan alamat email yang valid.';
              }

              return null;
            },
          ),
          const SizedBox(height: 21),
          AuthTextField(
            label: 'Kata Sandi',
            hint: 'Masukkan kata sandi',
            icon: Icons.lock_outline_rounded,
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) => _handleLogin(),
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
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.karasko,
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    BaseColor.karasko.withValues(alpha: 0.7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 19,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Text(
            'Belum memiliki akun?',
            style: TextStyle(
              color: Color(0xFF777C75),
              fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RegisterScreen(),
              ),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: BaseColor.caramel,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Buat akun',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
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
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandSection(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          28,
                          compact ? 30 : 38,
                          28,
                          24,
                        ),
                        child: Column(
                          children: [
                            _buildLoginForm(),
                            const SizedBox(height: 26),
                            _buildRegisterLink(),
                            const SizedBox(height: 30),
                            const Text(
                              'KARASKO  •  COFFEE & DAILY MOMENTS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF92978F),
                                fontSize: 9,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w500,
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
          },
        ),
      ),
    );
  }
}
