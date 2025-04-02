import 'package:get/get.dart';
import 'package:mobile/pages/app/setting/change_pw/pw_controller.dart';
import 'package:mobile/pages/app/setting/profile/profile_controller.dart';
import 'package:mobile/pages/app/setting/setting_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<PwController>(() => PwController());
  }
}