import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/routes/routes.dart';
import 'package:http/http.dart' as http;

class VerifyCodeController extends GetxController {
  final RxString email = ''.obs;
  final RxString code = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString commonError = ''.obs;

  @override
  void onInit() {
    email.value = Get.arguments as String;
    super.onInit();
  }


  Future<void> verifyCode() async {
    if (code.value.isEmpty) {
      commonError.value = 'Please enter code!';
      return;
    }

    if (code.value.length < 4) {
      commonError.value = 'Code must be 4 characters!';
      return;
    }

    commonError.value = '';

    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse('http://localhost:8000/verify-code'), body: {
        'email': email.value,
        'resetcode': code.value
      });

      if (res.statusCode == 400) {
        commonError.value = json.decode(res.body)['msg'];
      } else if (res.statusCode == 200) {
        Get.offNamed(AppRoutes.resetpassword, arguments: email.value);
      }
    } finally {
      isLoading.value = false;
    }
    

  }
}