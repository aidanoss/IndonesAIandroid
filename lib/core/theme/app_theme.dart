import 'package:flutter/material.dart';

class AppTheme {
  // Indonesian flag colors
  static const Color indonesianRed = Color(0xFFFF0000);
  static const Color indonesianWhite = Color(0xFFFFFFFF);

  // Text Styles
  static const String fontFamily = 'Poppins';

  static const TextTheme _textTheme = TextTheme(
    displayLarge:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),
    displayMedium:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),
    displaySmall:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),
    headlineLarge:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
    headlineMedium:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
    headlineSmall:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.normal),
    bodyMedium:
        TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: indonesianRed,
      secondary: indonesianRed.withOpacity(0.8),
      surface: indonesianWhite,
      onPrimary: indonesianWhite,
      onSecondary: indonesianWhite,
    ),
    scaffoldBackgroundColor: indonesianWhite,
    textTheme: _textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: indonesianRed,
      foregroundColor: indonesianWhite,
      elevation: 0,
      centerTitle: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: indonesianWhite,
      indicatorColor: indonesianRed.withOpacity(0.1),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: indonesianRed,
      foregroundColor: indonesianWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: indonesianRed),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: indonesianRed.withOpacity(0.8),
      secondary: indonesianRed.withOpacity(0.6),
      surface: Colors.grey[850]!,
      onPrimary: indonesianWhite,
      onSecondary: indonesianWhite,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      foregroundColor: indonesianWhite,
      elevation: 0,
      centerTitle: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      indicatorColor: indonesianRed.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: indonesianRed.withOpacity(0.8),
      foregroundColor: indonesianWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: indonesianRed.withOpacity(0.8)),
      ),
    ),
  );
}
