import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  final RxString userid = ''.obs;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxBool isDarkMode = false.obs;

  final currentPage = 0.obs;

  final pageController = PageController(initialPage: 0);

  final serverHost = Env.serverhost;

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    super.onInit();
    setInfo();
    // getInfo();
  }


  Future<void> setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userid.value = prefs.getString('user_id') ?? '';
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    isDarkMode.value = themeController.isDark.value;
  }

  Future<void> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.get(Uri.parse('$serverHost/user'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Cookie': rawCookie
    });

    if (res.statusCode == 200) {
      final data = res.body;
      prefs.setString('user_id', data);
      userid.value = data;
    }
  }


  void changePage(int index) {
    currentPage.value = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }
}