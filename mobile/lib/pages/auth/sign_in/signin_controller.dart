import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final showPassword = true.obs;

  final emailError = ''.obs;
  final passwordError = ''.obs;
  final commonError = ''.obs;
  final isLoading = false.obs;

  final serverHost = Env.serverhost;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> signin() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      commonError.value = 'Please fill all field!';
      return;
    } 

    commonError.value = '';

    if (!email.isEmail) {
      emailError.value = 'Email is not valid!';
      return;
    }

    emailError.value = '';

    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse('$serverHost/signin'), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        })
      );

      if (res.statusCode == 400) {
        commonError.value = 'Wrong email or password';
      } 
      else if (res.statusCode == 200 || res.statusCode == 201) {
        User user = User.fromJson(json.decode(res.body)['user']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final rawCookie = res.headers['set-cookie'] ?? '';

        await prefs.setString('user_id', user.id);
        await prefs.setString('email', user.email);
        await prefs.setString('name', user.name);
        await prefs.setString('image_url', user.imageUrl ?? '');
        await prefs.setString('cookie', rawCookie);
        Get.offAllNamed(AppRoutes.application);
      }

    } finally {
      isLoading.value = false;
    }
  }

    void goToForgotPw() {
      emailController.clear();
      passwordController.clear();
      emailError.value = '';
      commonError.value = '';
      passwordError.value = '';
      Get.toNamed(AppRoutes.forgotpassword);
  }
}