import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppProvider extends ChangeNotifier {
  // Theme
  bool _isDarkMode = false;
  final String _fontSize = AppConstants.mediumFont;
  double _fontSizeScale = 1.0;

  // Getters
  bool get isDarkMode => _isDarkMode;
  String get fontSize => _fontSize;
  double get fontSizeScale => _fontSizeScale;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Theme and Font Methods
  void toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void increaseFontSize() {
    _fontSizeScale = (_fontSizeScale + 0.1).clamp(0.8, 1.5);
    notifyListeners();
  }

  void decreaseFontSize() {
    _fontSizeScale = (_fontSizeScale - 0.1).clamp(0.8, 1.5);
    notifyListeners();
  }

  double getFontSizeValue() {
    switch (_fontSize) {
      case AppConstants.smallFont:
        return 0.9 * _fontSizeScale;
      case AppConstants.largeFont:
        return 1.1 * _fontSizeScale;
      default:
        return 1.0 * _fontSizeScale;
    }
  }
}
