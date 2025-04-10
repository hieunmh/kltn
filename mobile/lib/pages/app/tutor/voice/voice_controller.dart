import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class VoiceController extends GetxController {
  SpeechToText speedToText = SpeechToText();

  RxString recognizedWords = 'No hehe'.obs;
  RxBool isListening = false.obs;

  final serverHost = Env.serverhost;

  RxList<String> questions = <String>[].obs;
  RxList<String> answers = <String>[].obs;


  @override
  void onInit() {
    super.onInit();
    getQuestions();
    initSpeechToText();

    ever(answers, (value) {
      if (answers.length == questions.length) {
        print(1);
      }
    });
  }

  void getQuestions() async {
    print(1);
    final theory = Get.arguments['theory'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';
    final res = await http.post(Uri.parse('$serverHost/review_geminiAI'), headers: {
      'cookie': rawCookie
    }, body: {
      'model': 'gemini-2.0-pro-exp-02-05',
      'theory': theory
    });

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      print(data);
      questions.value = List<String>.from(data['response']);
    }
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
        if (result.finalResult && answers.length < questions.length - 1) {
          answers.add(result.recognizedWords);
        } else if (answers.length == questions.length - 1) {
          print('gui api');
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