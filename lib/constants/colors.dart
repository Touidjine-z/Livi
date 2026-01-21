import 'package:flutter/material.dart';

class AppColors {
  // Couleurs primaires
  static const Color primary = Color(0xFF007AFF); // Bleu
  static const Color primaryDark = Color(0xFF0051D5);
  static const Color primaryLight = Color(0xFFE3F2FD);

  // Couleurs secondaires
  static const Color secondary = Color(0xFF00BFA5); // Teal/Vert
  static const Color secondaryDark = Color(0xFF00897B);
  static const Color secondaryLight = Color(0xFFE0F2F1);

  // Couleurs de statut
  static const Color success = Color(0xFF4CAF50); // Vert
  static const Color warning = Color(0xFFFFC107); // Orange
  static const Color error = Color(0xFFF44336); // Rouge
  static const Color info = Color(0xFF2196F3); // Bleu ciel

  // Neutres
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF212121);
  static const Color onSurface = Color(0xFF212121);

  // Gris
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Transparence
  static const Color transparent = Colors.transparent;

  // Couleurs pour dégradé
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
