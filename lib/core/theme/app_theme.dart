
import 'package:flutter/material.dart';

import '../constants/themes/color_constants.dart';
import '../constants/themes/typography_constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: BaseColor.primary,
      brightness: Brightness.light,
      primary: BaseColor.primary,
      onPrimary: BaseColor.onPrimary,
      secondary: BaseColor.secondary,
      surface: BaseColor.surface,
      onSurface: BaseColor.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: BaseColor.surface,

      textTheme: const TextTheme(
        displayLarge: BaseTypography.displayLarge,
        displayMedium: BaseTypography.displayMedium,
        displaySmall: BaseTypography.displaySmall,
        headlineLarge: BaseTypography.headlineLarge,
        headlineMedium: BaseTypography.headlineMedium,
        headlineSmall: BaseTypography.headlineSmall,
        titleLarge: BaseTypography.titleLarge,
        titleMedium: BaseTypography.titleMedium,
        titleSmall: BaseTypography.titleSmall,
        bodyLarge: BaseTypography.bodyLarge,
        bodyMedium: BaseTypography.bodyMedium,
        bodySmall: BaseTypography.bodySmall,
        labelLarge: BaseTypography.labelLarge,
        labelMedium: BaseTypography.labelMedium,
        labelSmall: BaseTypography.labelSmall,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: BaseColor.surface,
        foregroundColor: BaseColor.charcoal,
        centerTitle: false,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BaseColor.primary,
          foregroundColor: BaseColor.onPrimary,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
