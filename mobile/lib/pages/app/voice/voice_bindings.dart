import 'package:get/get.dart';
import 'package:mobile/pages/app/voice/voice_controller.dart';

class VoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceController>(() => VoiceController());
  }
}