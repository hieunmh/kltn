import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/result/result_controller.dart';


class ResultBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController());
  }
}
