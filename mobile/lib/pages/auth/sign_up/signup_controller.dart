import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      repasswordError.value = '';
      return;
    }

    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse('http://localhost:8000/signup'), body: {
        'email': email,
        'password': password,
      });

      if (res.statusCode == 400) {
        commonError.value = 'Email have been registered!';
      } 
      else if (res.statusCode == 200) {
        // Get.toNamed(AppRoutes.application);
      }

    } finally {
      isLoading.value = false;
    }

  }
}