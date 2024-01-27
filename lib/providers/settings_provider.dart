import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLocale = "en";
  ThemeMode currentMode = ThemeMode.light;

  SettingsProvider() {
    loadSettings(); // Load settings from shared preferences when the class is instantiated.
  }

  bool isDarkMode() => currentMode == ThemeMode.dark;
  bool isArEnabled() => currentLocale == "ar";

  void setMode(ThemeMode newMode) {
    currentMode = newMode;
    saveSettings(); // Save the new mode to shared preferences.
    notifyListeners();
  }

  void setCurrentLocale(String newLocale) {
    currentLocale = newLocale;
    saveSettings(); // Save the new locale to shared preferences.
    notifyListeners();
  }

  // Define keys for your shared preferences
  static const String _localeKey = 'currentLocale';
  static const String _modeKey = 'currentMode';

  // Load settings from shared preferences
  Future<void> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocale = prefs.getString(_localeKey) ?? "en";
    currentMode = (prefs.getString(_modeKey) == "dark") ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Save settings to shared preferences
  Future<void> saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_localeKey, currentLocale);
    prefs.setString(_modeKey, isDarkMode() ? "dark" : "light");
  }
}
