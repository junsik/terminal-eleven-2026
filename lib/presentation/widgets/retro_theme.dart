/// 레트로 터미널 테마 상수
library;

import 'package:flutter/material.dart';

/// Matrix Green 색상 팔레트
class RetroColors {
  static const Color background = Color(0xFF0D0D0D);
  static const Color primary = Color(0xFF00FF41);
  static const Color primaryDim = Color(0xFF00CC33);
  static const Color secondary = Color(0xFF00AA28);
  static const Color error = Color(0xFFFF4136);
  static const Color warning = Color(0xFFFFDC00);
  static const Color success = Color(0xFF2ECC40);
  static const Color textPrimary = Color(0xFF00FF41);
  static const Color textSecondary = Color(0xFF00AA28);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color border = Color(0xFF00FF41);
  static const Color divider = Color(0xFF333333);
}

/// 레트로 터미널 테마
class RetroTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: RetroColors.background,
      colorScheme: const ColorScheme.dark(
        primary: RetroColors.primary,
        secondary: RetroColors.secondary,
        surface: RetroColors.surface,
        error: RetroColors.error,
        onPrimary: RetroColors.background,
        onSecondary: RetroColors.background,
        onSurface: RetroColors.textPrimary,
        onError: RetroColors.background,
      ),
      fontFamily: 'JetBrainsMono',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: RetroColors.textSecondary,
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          color: RetroColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: RetroColors.background,
        foregroundColor: RetroColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'JetBrainsMono',
          color: RetroColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: const CardThemeData(
        color: RetroColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(color: RetroColors.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: RetroColors.primary,
          foregroundColor: RetroColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: const TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: RetroColors.primary,
          side: const BorderSide(color: RetroColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: const TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RetroColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: RetroColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: RetroColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: RetroColors.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: RetroColors.textSecondary),
        hintStyle: const TextStyle(color: RetroColors.textSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: RetroColors.divider,
        thickness: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: RetroColors.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: RetroColors.surface,
        contentTextStyle: const TextStyle(
          fontFamily: 'JetBrainsMono',
          color: RetroColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: RetroColors.border),
        ),
      ),
    );
  }
}
