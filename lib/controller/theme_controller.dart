import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ThemeType { light, dark }

class ThemeController extends GetxController {
  var themeType = ThemeType.light.obs;

  ThemeMode getThemeMode() {
    return themeType.value == ThemeType.light ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    themeType.value = themeType.value == ThemeType.light ? ThemeType.dark : ThemeType.light;
    Get.changeThemeMode(getThemeMode());
  }
}
