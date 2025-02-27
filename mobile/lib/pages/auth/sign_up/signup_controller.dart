import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final nameController = TextEditingController();

  final showPassword = true.obs;
  final showRePassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowRePassword() {
    showRePassword.value = !showRePassword.value;
  }
}