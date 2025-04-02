import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final ThemeController themeController = Get.find<ThemeController>();
  final AppController appController = Get.find<AppController>();
  final serverHost = Env.serverhost;

  final name = ''.obs;
  final email = ''.obs;

  final newName = ''.obs;
  final newEmail = ''.obs;
  final imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setInfo();
  }

  Future<void> setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name.value = prefs.getString('name') ?? '';
    newName.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    newEmail.value = prefs.getString('email') ?? '';
  }

  Future<void> updateInfo() async {
    
  }

}