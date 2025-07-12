import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Load saved theme preference
  Future<void> loadThemePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme') ?? 'system';

    _themeMode = savedTheme == 'dark'
        ? ThemeMode.dark
        : savedTheme == 'light'
        ? ThemeMode.light
        : ThemeMode.system;

    notifyListeners();
  }

  // Toggle between light/dark theme
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'theme',
      _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
