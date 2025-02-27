import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_up/signup_controller.dart';

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}