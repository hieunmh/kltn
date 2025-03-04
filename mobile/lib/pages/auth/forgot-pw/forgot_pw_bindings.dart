import 'package:get/get.dart';
import 'package:mobile/pages/auth/forgot-pw/forgot_pw_controller.dart';

class ForgotPwBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPwController());
  }
}