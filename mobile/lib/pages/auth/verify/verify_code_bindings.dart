import 'package:get/get.dart';
import 'package:mobile/pages/auth/verify/verify_code_controller.dart';

class VerifyCodeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyCodeController());
  }
}