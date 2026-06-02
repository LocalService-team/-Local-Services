import 'package:flutter/material.dart';

class AppTheme {
  static const Color homeTeal = Color(0xFF005A60);
  static const Color servicesPurple = Color(0xFF621B66);
  static const Color detailGreen = Color(0xFF4E7043);

  static const Color accentBrown = Color(0xFF8D5B24);
  static const Color backgroundLight = Color(0xFFE3EAE7);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color catBakery = Color(0xFF909A6B);
  static const Color catMedical = Color(0xFF83B4B7);
  static const Color catTransport = Color(0xFFE5E9E8);
  static const Color catHomeServices = Color(0xFFF1A64A);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: homeTeal,
      scaffoldBackgroundColor: backgroundLight,

      colorScheme: const ColorScheme.light(
        primary: homeTeal,
        secondary: servicesPurple,
        tertiary: detailGreen,
        surface: cardLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1C1B1F),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: homeTeal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBrown,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: homeTeal,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
    );
  }
}