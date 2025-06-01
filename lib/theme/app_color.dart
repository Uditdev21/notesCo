import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme_controller.dart';

class AppColors {
  static final ThemeController themeController = Get.find();

  static Color get background =>
      themeController.isDarkMode ? Colors.black : Colors.white;

  static Color get text =>
      themeController.isDarkMode ? Colors.white : Colors.black;

  static Color get card =>
      themeController.isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;

  static Color get button =>
      themeController.isDarkMode ? Colors.tealAccent : Colors.blue;
}
