import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('isDark') ?? false;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeTheme(bool value) async {
    isDark.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDark', value);

    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}