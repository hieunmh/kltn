import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TutorController extends GetxController {

  ThemeController themeController = Get.find<ThemeController>();

  final serverHost = Env.serverhost;
  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final learnController = TextEditingController(text: '');
  final learnText = ''.obs;
  final learnTextError = ''.obs;
  final isLoadingGenerate = false.obs;

  final RxString level = ''.obs;
  final subjectController = TextEditingController(text: '');
  final RxString suggestTheme = ''.obs;
  final RxString suggestError = ''.obs;

  Future<void> createSuggest() async {
    print('createSuggest');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    if (level.value.isEmpty || subjectController.text.isEmpty) {
      suggestError.value = 'Vui lòng chọn trình độ và môn học để tạo chủ đề';
      return;
    }

    suggestError.value = '';

    isLoadingGenerate.value = true;
    final suggest = await http.post(Uri.parse('$serverHost/suggest_theme_AI'), headers: {
      'cookie': rawCookie
    }, body: {
      'level': level.value,
      'subject': subjectController.text,
      'model': Env.geminiModel
    }); 

    if (suggest.statusCode == 200 || suggest.statusCode == 201) {
      print(json.decode(suggest.body)['response']);
      suggestTheme.value = json.decode(suggest.body)['response'];
      isLoadingGenerate.value = false;
    }
  }

  void setLevel(String value) {
    level.value = value;
  }

  void onstart() {
    Get.back();
    if (suggestTheme.value.isEmpty || level.value.isEmpty || subjectController.text.isEmpty) {
      suggestError.value = 'Vui lòng tạo chủ đề trước khi bắt đầu';
      return;
    }

    Get.toNamed(AppRoutes.review, arguments: {
      'topic': suggestTheme.value,
    });
    learnController.clear();
    subjectController.clear();
    level.value = '';
    suggestTheme.value = '';
  }
}