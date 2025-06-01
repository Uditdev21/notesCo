import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Reactive theme mode
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    bool isDark = _loadThemeFromStorage();
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  // Load theme from storage
  bool _loadThemeFromStorage() => _box.read(_key) ?? false;

  // Save theme to storage
  void _saveThemeToStorage(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Toggle theme
  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
      _saveThemeToStorage(true);
    } else {
      themeMode.value = ThemeMode.light;
      _saveThemeToStorage(false);
    }
    Get.changeThemeMode(themeMode.value);
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}
