
import 'dart:async';

import 'package:flutter/material.dart';

import '../../auth/screens/login_screen.dart';
import '../../../core/constants/themes/color_constants.dart';
import '../../../core/constants/themes/size_constants.dart';
import '../../../core/constants/themes/typography_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, _, _) => const LoginScreen(),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 450),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.cream,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double compactFactor =
                constraints.maxHeight < 600 ? 0.8 : 1.0;

            return Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 14 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 94 * compactFactor,
                      height: 94 * compactFactor,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECEFE8),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE1E6DD),
                        ),
                      ),
                      child: Icon(
                        Icons.coffee_rounded,
                        size: 48 * compactFactor,
                        color: BaseColor.karasko,
                      ),
                    ),
                    Gap.h20,
                    Text(
                      'Karasko',
                      style: BaseTypography.displayLarge.copyWith(
                        color: BaseColor.karasko,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                    Gap.h8,
                    const Text(
                      'Your daily coffee companion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF777C75),
                        fontSize: 13,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Gap.h32,
                    SizedBox(
                      width: 22 * compactFactor,
                      height: 22 * compactFactor,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: BaseColor.karasko,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
