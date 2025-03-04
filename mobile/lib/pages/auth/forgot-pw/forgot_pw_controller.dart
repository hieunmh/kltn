import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/routes/routes.dart';

class ForgotPwController extends GetxController {
  final emailController = TextEditingController();
  final RxString code = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString commonError = ''.obs;
  final RxString serverSuccess = 'Please check your mail to get reset code!'.obs;  

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

    Get.offNamed(AppRoutes.verifycode, arguments: emailController.text);

    // try {
    //   isLoading.value = true;
    //   final res = await http.post(Uri.parse('http://localhost:8000/forgot-password'), body: {
    //     'email': emailController.text
    //   });

    //   if (res.statusCode == 400) {
    //     commonError.value = 'Email not registered!';
    //   } else if (res.statusCode == 200) {
    //     serverSuccess.value = 'Reset code has been sent to your email!';
    //   } else if (res.statusCode == 500) {
    //     commonError.value = 'Error sending reset code to your email!';
    //   }
    // } finally {
    //   isLoading.value = false;
    // }
  }
}