import 'package:get/get.dart';
import 'package:mobile/pages/auth/sign_in/signin_controller.dart';

class SigninBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SigninController());
  }
}