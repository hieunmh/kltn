import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/routes/routes.dart';

class ForgotPwController extends GetxController {
  final emailController = TextEditingController();
  final RxString code = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString commonError = ''.obs; 

  final serverHost = Env.serverhost;

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty) {
      commonError.value = 'Please enter email address!';
      return;
    }

    if (!emailController.text.isEmail) {
      commonError.value = 'Email is not valid!';
      return;
    }

    commonError.value = '';

    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse('$serverHost/auth/forgot-password'), body: {
        'email': emailController.text
      });

      print(res.body);

      if (res.statusCode == 400) {
        commonError.value = 'Please enter email address!';
      } else if (res.statusCode == 404) {
        commonError.value = 'Email not registered!';
      } else if (res.statusCode == 200) {
        Get.offNamed(AppRoutes.verifycode, arguments: emailController.text);
      } else if (res.statusCode == 500) {
        commonError.value = 'Error sending reset code to your email!';
      }
    } finally {
      isLoading.value = false;
    }
  }
}