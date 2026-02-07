import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // 1. Define the key for storage
  static const String _themeKey = 'isDarkMode';

  // 2. Variable to hold the current mode
  // We start with 'system' by default, or you can force light/dark
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // 3. Helper to check if we are currently in Dark Mode
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // If system, ask the OS what the brightness is
      return WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // 4. Toggle the theme
  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    update(); // Notify GetMaterialApp to rebuild

    // Save to storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);

    // Force GetX to update the app theme immediately
    Get.changeThemeMode(_themeMode);
  }

  // 5. Load saved theme from storage
  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isDark = prefs.getBool(_themeKey);

    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    update();
    Get.changeThemeMode(_themeMode);
  }
}