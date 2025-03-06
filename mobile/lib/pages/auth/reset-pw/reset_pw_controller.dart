import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/routes/routes.dart';

class ResetPwController extends GetxController {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final showPassword = true.obs;
  final showRePassword = true.obs;

  final passwordError = ''.obs;
  final repasswordError = ''.obs;
  final commonError = ''.obs;

  final RxBool isLoading = false.obs;

  final serverHost = Env.serverhost;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowRePassword() {
    showRePassword.value = !showRePassword.value;
  }

  Future<void> resetPassword() async {
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Please enter password!';
      return;
    }

    passwordError.value = '';

    if (rePasswordController.text.isEmpty) {
      repasswordError.value = 'Please re-enter password!';
      return;
    }

    if (rePasswordController.text != passwordController.text) {
      repasswordError.value = 'Password do not match!';
      return;
    }

    repasswordError.value = '';

    try {
      isLoading.value = true;
      await http.patch(Uri.parse('$serverHost/reset-password'), body: {
        'email': Get.arguments as String,
        'password': passwordController.text
      });



      Get.offNamed(AppRoutes.resetsuccess);

    } finally {
      isLoading.value = false;
    }
  }
}