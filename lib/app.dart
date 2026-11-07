import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';

class KaraskoApp extends StatelessWidget {
  const KaraskoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karasko',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
