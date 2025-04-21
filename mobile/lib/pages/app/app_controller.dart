import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  final RxString userid = ''.obs;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;
  final RxBool isDarkMode = false.obs;
  final user = User(
    id: '',
    name: '',
    email: '',
    imageUrl: '',
  ).obs;

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
    imageUrl.value = prefs.getString('image_url') ?? '';
    isDarkMode.value = themeController.isDark.value;

    user.value = User(
      id: prefs.getString('user_id') ?? '',
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      imageUrl: prefs.getString('image_url') ?? '',
    );
  }

  Future<void> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.get(Uri.parse('$serverHost/user/get-info'), headers: {
      'Cookie': rawCookie
    });

    if (res.statusCode == 200) {
      final data = json.decode(res.body)['user'];
      userid.value = data['id'];
      name.value = data['name'];
      email.value = data['email'];
      imageUrl.value = data['image_url'];

      user.value = User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        imageUrl: data['image_url'],
      ); 
    }
  }


  void changePage(int index) {
    currentPage.value = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }
}