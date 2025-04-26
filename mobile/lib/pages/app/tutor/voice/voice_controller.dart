import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/theme_controller.dart';
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
  RxInt currentQuestionIndex = 0.obs;
  ThemeController themeController = Get.find<ThemeController>();


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
    final res = await http.post(Uri.parse('$serverHost/review_AI'), headers: {
      'cookie': rawCookie
    }, body: {
      'model': Env.geminiModel,
      'theory': theory
    });

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      print(data);
      if (data['response'] is List) {
        questions.value = List<String>.from(data['response']);
      } else if (data['response'] is String) {
        try {
          final parsedResponse = json.decode(data['response']);
          if (parsedResponse is List) {
            questions.value = List<String>.from(parsedResponse);
          } else {
            questions.value = [data['response'].toString()];
          }
        } catch (e) {
          questions.value = [data['response'].toString()];
        }
      } else {
        questions.value = ["Không thể tải câu hỏi. Vui lòng thử lại."];
        print("Error: Unexpected response format: ${data['response']}");
      }
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
        recognizedWords.value = result.recognizedWords;
        if (result.finalResult) {
          answers.add(result.recognizedWords);
          if (answers.length < questions.length) {
            currentQuestionIndex.value++;
          }
        } 
        if (answers.length == questions.length) {
          print('gui api');
          sendAnswer();
        }
      },
      localeId: 'vi-VN',
    );
  }


  void stopListening() async {
    isListening.value = false;
    await speedToText.stop();
  }

  Future<void> sendAnswer() async {
    print('voice 1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';
    List<Map<String, String>> jsonData = [];
    for (int i = 0; i < questions.length; i++) {
      jsonData.add({
        'question': questions[i],
        'answer': answers[i]
      });
    }
    final res = await http.post(Uri.parse('$serverHost/voice_AI'), headers: {
        'cookie': rawCookie
      }, 
      body: {
        'model': Env.geminiModel,
        'data': json.encode(jsonData)
      }
    );

    print(res.body);

    if (res.statusCode == 200) {
      Get.offNamed(AppRoutes.result, arguments: {
        'results': json.decode(res.body)['response'],
        'questions': questions,
      });
    }
  }
}