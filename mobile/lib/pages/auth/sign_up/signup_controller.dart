import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final showPassword = true.obs;
  final showRePassword = true.obs;
  final isLoading = false.obs;

  final emailError = ''.obs;
  final passwordError = ''.obs;
  final repasswordError = ''.obs;
  final commonError = ''.obs;

  final serverHost = Env.serverhost;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowRePassword() {
    showRePassword.value = !showRePassword.value;
  }

  Future<void> signup() async {
    final email = emailController.text;
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (email.isEmpty || password.isEmpty || rePassword.isEmpty) {
      commonError.value = 'Please fill all field!';
      return;
    } 

    commonError.value = '';

    if (!email.isEmail) {
      emailError.value = 'Email is not valid!';
      return;
    }

    emailError.value = '';

    if (password != rePassword) {
      repasswordError.value = 'Comfirm password not match';
      return;
    }

    repasswordError.value = '';

    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse('$serverHost/signup'), body: {
        'email': email,
        'password': password,
      });

      if (res.statusCode == 400) {
        commonError.value = 'Email have been registered!';
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
}