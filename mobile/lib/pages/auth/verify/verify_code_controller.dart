import 'package:get/get.dart';
import 'package:mobile/routes/routes.dart';

class VerifyCodeController extends GetxController {
  final RxString email = ''.obs;
  final RxString code = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString commonError = ''.obs;

  @override
  void onInit() {
    email.value = Get.arguments as String;
    super.onInit();
  }


  Future<void> verifyCode() async {
    if (code.value.isEmpty) {
      commonError.value = 'Please enter code!';
      return;
    }

    if (code.value.length < 4) {
      commonError.value = 'Code must be 4 characters!';
      return;
    }

    commonError.value = '';
    Get.offNamed(AppRoutes.resetpassword);
  }
}