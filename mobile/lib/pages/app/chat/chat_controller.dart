import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/models/chat.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {

  final RxList<Chat> chatList = <Chat>[].obs;

  final serverHost = Env.serverhost;

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> getAllChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final chatlist = await http.get(Uri.parse('$serverHost/get-all-chat'), headers: {
      'cookie': rawCookie
    });

    if (chatlist.statusCode == 404) {
      chatList.value = [];
    } else if (chatlist.statusCode == 200) {
      final data = json.decode(chatlist.body)['chats'] as List;
      chatList.value = data.map((p) => Chat.fromJson(p as Map<String, dynamic>)).toList();
    }
  }
}