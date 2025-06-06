import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/review/review_controller.dart';
import 'package:mobile/pages/app/tutor/tutor_controller.dart';
import 'package:mobile/pages/app/tutor/voice/voice_controller.dart';
import 'package:mobile/pages/app/tutor/result/result_controller.dart';

class VoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TutorController>(() => TutorController());
    Get.lazyPut<ReviewController>(() => ReviewController());
    Get.lazyPut<VoiceController>(() => VoiceController());
    Get.lazyPut<ResultController>(() => ResultController());
  }
}