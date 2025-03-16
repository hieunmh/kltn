import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  final RxString userid = ''.obs;
  final RxString name = ''.obs;
  final RxString email = ''.obs;

  final currentPage = 0.obs;

  final pageController = PageController(initialPage: 0);

  final serverHost = Env.serverhost;

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

    print(res.body);

    // if (res.statusCode == 200) {
    //   final data = res.body;
    //   prefs.setString('user_id', data);
    //   userid.value = data;
    // }
  }

  Future<void> signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.post(Uri.parse('$serverHost/signout'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Cookie': rawCookie
    });

    prefs.remove('user_id');
    prefs.remove('name');
    prefs.remove('email');
    // Get.offNamed(AppRoutes.signup);
    if (res.statusCode == 200) {
      Get.offNamed(AppRoutes.signup);
    }
  }


  void changePage(int index) {
    currentPage.value = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }
}