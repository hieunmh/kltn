import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}