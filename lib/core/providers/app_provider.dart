import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppProvider extends ChangeNotifier {
  // Theme
  bool _isDarkMode = false;
  String _fontSize = AppConstants.mediumFont;

  // Voice Settings
  bool _isVoiceEnabled = true;
  double _voiceSpeed = 1.0;
  double _voicePitch = 1.0;

  // Getters
  bool get isDarkMode => _isDarkMode;
  String get fontSize => _fontSize;
  bool get isVoiceEnabled => _isVoiceEnabled;
  double get voiceSpeed => _voiceSpeed;
  double get voicePitch => _voicePitch;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Methods
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setFontSize(String size) {
    _fontSize = size;
    notifyListeners();
  }

  void toggleVoice() {
    _isVoiceEnabled = !_isVoiceEnabled;
    notifyListeners();
  }

  void setVoiceSpeed(double speed) {
    _voiceSpeed = speed;
    notifyListeners();
  }

  void setVoicePitch(double pitch) {
    _voicePitch = pitch;
    notifyListeners();
  }

  double getFontSizeValue() {
    switch (_fontSize) {
      case AppConstants.smallFont:
        return 0.9;
      case AppConstants.largeFont:
        return 1.1;
      default:
        return 1.0;
    }
  }
}
