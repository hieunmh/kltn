import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/pages/app/profile/profile_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => ProfileController());
  }
}