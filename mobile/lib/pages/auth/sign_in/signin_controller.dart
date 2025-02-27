import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final showPassword = true.obs;

  void toggleShowPassword() {
    print(1);
    showPassword.value = !showPassword.value;
  }
}