import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewController extends GetxController {

  RxString topic = ''.obs;
  RxString theory = ''.obs;

  final serverHost = Env.serverhost;
  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final ThemeController themeController = Get.find<ThemeController>();
  
  @override
  void onInit() {
    super.onInit();
    getReview();
  }

  Future<void> getReview() async {
    topic.value = Get.arguments['topic'] ?? '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.post(Uri.parse('$serverHost/topic_geminiAI'), headers: {
      'cookie': rawCookie
    }, body: {
      'topic': topic.value,
      'model': 'gemini-2.0-pro-exp-02-05'
    });

    print(res.body);

    if (res.statusCode == 200) {
      theory.value = json.decode(res.body)['response']['theory'];
    } else {
      Get.snackbar('Error', 'Failed to get review');
      print('Error: ${res.statusCode}');
      print('Error: ${res.body}');
    }
  }
}