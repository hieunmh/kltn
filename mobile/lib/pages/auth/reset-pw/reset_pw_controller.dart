import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPwController extends GetxController {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final showPassword = true.obs;
  final showRePassword = true.obs;

  final passwordError = ''.obs;
  final repasswordError = ''.obs;

  final RxBool isLoading = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowRePassword() {
    showRePassword.value = !showRePassword.value;
  }
}