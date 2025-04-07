import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceController extends GetxController {
  SpeechToText speedToText = SpeechToText();

  RxString recognizedWords = 'No hehe'.obs;
  RxBool isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeechToText();
  }

  void initSpeechToText() async {
    isListening.value = false;
    recognizedWords.value = '';
    await speedToText.initialize();
  }

  void startListening() async {
    isListening.value = true;
    recognizedWords.value = '';
    await speedToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          recognizedWords.value = result.recognizedWords;
        } 
      },
      localeId: 'vi-VN',
    );
  }

  void stopListening() async {
    isListening.value = false;
    await speedToText.stop();
  }
}