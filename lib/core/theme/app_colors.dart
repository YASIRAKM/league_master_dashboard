import 'package:flutter/material.dart';

class AppColors {
  // Primary - Sky Blue
  static const Color primary = Color(0xFF4FC3F7); // Sky Blue
  static const Color primaryVariant = Color(0xFF039BE5);

  // Secondary
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);

  // Backgrounds
  // static const Color background = Color(0xFFE1F5FE); // Very light blue
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);

  // Text
  static const Color onPrimary =
      Colors.white; // Or Dark depending on contrast, white usually ok on 4FC3F7
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;
  static const Color onError = Colors.white;

  // Custom UI Elements
  static const Color inputFill =
      Color(0xFFF5F6F8); // Very light grey/blue for inputs
  static const Color inputIcon = Color(0xFF9E9E9E);
  static const Color darkButton =
      Color(0xFF1E1E2E); // Dark almost black for buttons
}
