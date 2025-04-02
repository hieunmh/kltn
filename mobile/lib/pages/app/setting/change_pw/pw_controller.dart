import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PwController extends GetxController {
  final oldPw = TextEditingController();
  final newPw = TextEditingController();
  final reNewPw = TextEditingController();

  final ThemeController themeController = Get.find<ThemeController>();

  final serverHost = Env.serverhost;

  final oldPwError = ''.obs;
  final newPwError = ''.obs;
  final reNewPwError = ''.obs;
  final commonError = ''.obs;

  final showOldPw = false.obs;
  final showNewPw = false.obs;
  final showReNewPw = false.obs;

  final isLoading = false.obs;

  Future<void> changePassword() async {
    resetError();
    if (oldPw.text.isEmpty || newPw.text.isEmpty || reNewPw.text.isEmpty) {
      commonError.value = 'Please fill all field!';
      return;
    }

    commonError.value = '';

    if (newPw.text == oldPw.text) {
      newPwError.value = 'New password cannot be the same as old password!';
      return;
    }

    newPwError.value = '';

    if (newPw.text != reNewPw.text) {
      reNewPwError.value = 'Password does not match!';
      return;
    }

    reNewPwError.value = '';

    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.patch(Uri.parse('$serverHost/user/change-password'), headers: {
        'Cookie': rawCookie
      },
      body: {
        'oldPassword': oldPw.text,
        'newPassword': newPw.text,
      }
    );

    if (res.statusCode == 400 || res.statusCode == 500) {
      oldPwError.value = 'Old password is incorrect!';
      isLoading.value = false;
    } else if (res.statusCode == 200 || res.statusCode == 201) {
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        message: 'Password changed successfully!',
        duration: Duration(seconds: 2),
      ));
      oldPw.text = '';
      newPw.text = '';
      reNewPw.text = '';
      isLoading.value = false;
    } else {
      commonError.value = 'Something went wrong!';
      isLoading.value = false;
    }
  }

  void resetError() {
    oldPwError.value = '';
    newPwError.value = '';
    reNewPwError.value = '';
    commonError.value = '';
  }
}