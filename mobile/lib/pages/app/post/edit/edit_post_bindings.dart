import 'package:get/get.dart';
import 'package:mobile/pages/app/post/edit/edit_post_controller.dart';

class EditPostBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditPostController());
  }
}
