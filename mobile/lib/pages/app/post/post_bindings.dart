import 'package:get/get.dart';
import 'package:mobile/pages/app/post/post_controller.dart';

class PostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
  }
}