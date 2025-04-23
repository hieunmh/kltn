import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;
  static SharedPreferences? _prefs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    isDark.value = _prefs?.getBool('isDark') ?? false;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> getTheme() async {
    if (_prefs == null) {
      await _initPrefs();
    } else {
      isDark.value = _prefs?.getBool('isDark') ?? false;
      Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    }
  }

  Future<void> changeTheme(bool value) async {
    isDark.value = value;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool('isDark', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}