import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primaryBlue = Color(
    0xFF2563EB,
  ); // Matches the bright blue buttons
  static const Color primaryBlueLight = Color(
    0xFFEFF6FF,
  ); // Light blue background for interactive elements

  // Text
  static const Color textMain = Color(
    0xFF111827,
  ); // Very dark gray/black for main text
  static const Color textSecondary = Color(
    0xFF6B7280,
  ); // Gray for subtitles and descriptions
  static const Color textLight = Color(
    0xFF9CA3AF,
  ); // Lighter gray for placeholders or disabled text
  static const Color textWhite = Colors.white;

  // Background and Surfaces
  static const Color background = Colors.white;
  static const Color surfaceLight = Color(
    0xFFF9FAFB,
  ); // Very light gray for cards/sections
  static const Color border = Color(
    0xFFE5E7EB,
  ); // Light gray for borders/dividers

  // Specific UI Elements
  static const Color userBubble = primaryBlue;
  static const Color aiBubble = surfaceLight;
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
}
