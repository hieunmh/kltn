import 'package:get/get.dart';
import 'package:mobile/pages/app/post/create/create_post_controller.dart';

class CreatePostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}