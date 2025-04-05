import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/review/review_controller.dart';

class ReviewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController());
  }
}