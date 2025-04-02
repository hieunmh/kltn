import 'package:get/get.dart';
import 'package:mobile/pages/app/setting/change_pw/pw_controller.dart';

class PwBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PwController>(() => PwController());
  }
}