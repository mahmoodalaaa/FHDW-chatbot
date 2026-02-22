import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
    letterSpacing: -0.5,
  ); // Without google fonts import for now if we want to add it later we can apply GoogleFonts.inter()

  static TextStyle h2 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
    letterSpacing: -0.5,
  );

  static TextStyle h3 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );

  static TextStyle h4 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );

  // Body Text
  static TextStyle bodyLg = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textMain,
  );

  static TextStyle bodyMd = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textMain,
  );

  static TextStyle bodySm = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textMain,
  );

  // Subtitles / Secondary text
  static TextStyle subtitle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Buttons
  static TextStyle button = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textWhite,
  );

  // Add GoogleFonts.inter to all
  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: h1,
      displayMedium: h2,
      displaySmall: h3,
      headlineMedium: h4,
      bodyLarge: bodyLg,
      bodyMedium: bodyMd,
      bodySmall: bodySm,
      titleMedium: subtitle,
      labelLarge: button,
    );
  }
}
