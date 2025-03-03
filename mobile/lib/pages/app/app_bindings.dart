import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
  }
}