import 'package:get/get.dart';
import 'package:mobile/pages/app/setting/setting_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}