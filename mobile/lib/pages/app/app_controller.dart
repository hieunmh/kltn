import 'package:get/get.dart';
import 'package:mobile/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  final RxString userid = ''.obs;
  final RxString name = ''.obs;
  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setInfo();
  }

  Future<void> setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userid.value = prefs.getString('user_id') ?? '';
    name.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
  }

  Future<void> signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.post(Uri.parse('http://localhost:8000/signout'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Cookie': rawCookie
    });

    prefs.remove('user_id');
    prefs.remove('name');
    prefs.remove('email');
    // Get.offNamed(AppRoutes.signup);
    if (res.statusCode == 200) {
      Get.offNamed(AppRoutes.signup);
    }
  }
}