import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/config/env.dart';
import 'package:http/http.dart' as http;


class SettingController extends GetxController {

  final serverHost = Env.serverhost;
  final RxBool isLoading = false.obs;

  final appController = Get.find<AppController>();
  final ThemeController themeController = Get.find<ThemeController>();

  Future<void> signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';
    

    final res = await http.post(Uri.parse('$serverHost/auth/signout'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Cookie': rawCookie
    });

    prefs.remove('user_id');
    prefs.remove('name');
    prefs.remove('email');

    if (res.statusCode == 200) {
      Get.offNamed(AppRoutes.signup);
    }
  }
}