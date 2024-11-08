import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color primaryRed = Color(0xFFFF0000);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  
  // Dark Mode Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFFE0E0E0);
  static const Color textMedium = Color(0xFFA0A0A0);
  static const Color accentDark = Color(0xFFAA0000);

  // Gradient Definitions
  static const LinearGradient redGradient = LinearGradient(
    colors: [
      primaryRed,
      primaryRed,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [
      surfaceDark,
      backgroundDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static const String fontFamily = 'Poppins';

  static TextTheme _createTextTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily, 
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily, 
        fontWeight: FontWeight.normal,
        color: secondaryColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily, 
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: fontFamily,
    
    colorScheme: ColorScheme.light(
      primary: primaryRed,
      secondary: primaryRed.withOpacity(0.8),
      surface: backgroundLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),

    scaffoldBackgroundColor: backgroundLight,
    textTheme: _createTextTheme(Colors.black87, Colors.black54),

    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundLight,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundLight,
      selectedItemColor: primaryRed,
      unselectedItemColor: Colors.grey[600],
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryRed, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    
    colorScheme: ColorScheme.dark(
      primary: accentDark,
      secondary: accentDark.withOpacity(0.8),
      surface: surfaceDark,
      onPrimary: textLight,
      onSecondary: textLight,
    ),

    scaffoldBackgroundColor: backgroundDark,
    textTheme: _createTextTheme(textLight, textMedium),

    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: textLight,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: accentDark,
      unselectedItemColor: textMedium,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: accentDark, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    cardTheme: CardTheme(
      color: surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // IndonesAI Banner Widget
  static Widget createBanner({
    bool isDarkMode = false,
    double height = 60,
    double fontSize = 20,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: isDarkMode 
          ? const LinearGradient(
              colors: [surfaceDark, backgroundDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: [primaryRed, primaryRed.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'IndonesAI',
          style: TextStyle(
            color: isDarkMode ? textLight : Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
