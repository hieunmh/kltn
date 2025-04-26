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
  final RxString model = 'geminiai'.obs;
  
  @override
  void onInit() {
    super.onInit();
    getReview();
  }

  Future<void> getReview() async {
    topic.value = Get.arguments['topic'] ?? '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final res = await http.post(Uri.parse('$serverHost/topic_AI'), headers: {
      'cookie': rawCookie
    }, body: {
      'topic': topic.value,
      'model': Env.geminiModel
    });

    print(res.body);

    if (res.statusCode == 200) {
      try {
        final data = json.decode(res.body);
        if (data['response'] is String) {
          try {
            final responseObject = json.decode(data['response']);
            // Chỉ lấy phần theory nếu có
            if (responseObject is Map && responseObject.containsKey('theory')) {
              theory.value = responseObject['theory'];
            } else {
              theory.value = 'Không thể tải lý thuyết. Vui lòng thử lại.';
            }
          } catch (e) {
            // Nếu không thể parse JSON, sử dụng trực tiếp response
            theory.value = data['response'];
          }
        } else if (data['response'] is Map) {
          // Nếu response đã là một đối tượng Map
          if (data['response'].containsKey('theory')) {
            theory.value = data['response']['theory'];
          } else {
            theory.value = 'Không thể tải lý thuyết. Vui lòng thử lại.';
          }
        } else {
          theory.value = 'Không thể tải lý thuyết. Vui lòng thử lại.';
        }
      } catch (e) {
        theory.value = 'Lỗi khi xử lý phản hồi từ server.';
      }
    } else {
      Get.snackbar('Error', 'Failed to get review');
      print('Error: ${res.statusCode}');
      print('Error: ${res.body}');
    }
  }
}