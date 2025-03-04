import 'package:get/get.dart';
import 'package:mobile/pages/auth/reset-pw/reset_pw_controller.dart';

class ResetPwBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPwController());
  }
}