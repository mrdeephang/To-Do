import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePrefs();
  }

  Future<void> _loadThemePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isInitialized = true;
    notifyListeners();
  }

  // Method to check if theme is loaded
  bool get isThemeLoaded => _isInitialized;

  // Auto-detect device theme
  Future<void> setAutoTheme(BuildContext context) async {
    final brightness = MediaQuery.of(context).platformBrightness;
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = brightness == Brightness.dark;
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }
}
