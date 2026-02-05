import 'package:flutter/material.dart';

/// App color constants based on Material 3 design system
/// Primary color: #6750A4 (Purple)
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6750A4);
  static const Color primaryLight = Color(0xFFF5F0FF);
  static const Color primaryDark = Color(0xFFD0BCFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Colors
  static const Color secondary = Color(0xFF625B71);
  static const Color secondaryLight = Color(0xFFF3EDF7);
  static const Color secondaryDark = Color(0xFFCCC2DC);

  // Tertiary Colors
  static const Color tertiary = Color(0xFF7D5260);
  static const Color tertiaryDark = Color(0xFFEFB8C8);

  // Error Colors
  static const Color error = Color(0xFFB3261E);
  static const Color errorDark = Color(0xFFF2B8B5);
  static const Color errorContainer = Color(0xFFF9DEDC);

  // Success Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFE8F5E9);

  // Warning Colors
  static const Color warning = Color(0xFFED6C02);
  static const Color warningLight = Color(0xFFFFF4E5);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFDFCFF);
  static const Color backgroundDark = Color(0xFF1B1B1F);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF24242A);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color surfaceVariantDark = Color(0xFF49454F);

  // Text Colors
  static const Color textPrimary = Color(0xFF1D1B20);
  static const Color textSecondary = Color(0xFF49454F);
  static const Color textSecondaryDark = Color(0xFFCAC4D0);
  static const Color textTertiary = Color(0xFF79747E);
  static const Color textDisabled = Color(0xFFB0B0B0);

  // Outline Colors
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFE7E0EC);
  static const Color outlineDark = Color(0xFF938F99);
  static const Color outlineVariantDark = Color(0xFF49454F);

  // Social Auth Colors
  static const Color googleRed = Color(0xFFDB4437);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color appleBlack = Color(0xFF000000);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6750A4),
    Color(0xFF9A82DB),
  ];

  static const List<Color> splashGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFF5F0FF),
  ];

  // Status Colors
  static const Color active = Color(0xFF4CAF50);
  static const Color inactive = Color(0xFFBDBDBD);
  static const Color pending = Color(0xFFFFC107);

  // Clothing Category Colors (for tags)
  static const Color categoryTop = Color(0xFF5C6BC0);
  static const Color categoryBottom = Color(0xFF26A69A);
  static const Color categoryDress = Color(0xFFEC407A);
  static const Color categoryOuterwear = Color(0xFF8D6E63);
  static const Color categoryShoes = Color(0xFF78909C);
  static const Color categoryAccessory = Color(0xFFFFB74D);
}
