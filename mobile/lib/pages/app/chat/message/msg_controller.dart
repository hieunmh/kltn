import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/chat.dart';
import 'package:mobile/models/message.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/pages/app/chat/chat_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MsgController extends GetxController {

  final serverHost = Env.serverhost;

  RxList<Message> messages = <Message>[].obs;

  final msgController = TextEditingController(text: '');

  final ThemeController themeController = Get.find<ThemeController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  void onInit() {
    super.onInit();
    messages.add(Get.arguments['message'] as Message);  
    createAiMessage();
  }

  Future<void> createAiMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final usermsg = Get.arguments['message'] as Message;
    final chat = Get.arguments['chat'] as Chat;

    // get AI response
    final aires = await http.post(Uri.parse('$serverHost/gemini_ai'), body: {
      'text': usermsg.message,
      'model': 'gemini-2.0-pro-exp-02-05'
    });

    print(json.decode(aires.body)['response']['title']);

    // creaste AI message
    final aimsg = await http.post(Uri.parse('$serverHost/create-message'), headers: {
      'cookie': rawCookie
    }, body: {
      'role': 'assistant',
      'chat_id': usermsg.chatid,
      'message': json.decode(aires.body)['response']['content']
    });

    if (aimsg.statusCode == 200 || aimsg.statusCode == 201) {
      final data = json.decode(aimsg.body)['message'] as Map<String, dynamic>;
      messages.add(Message.fromJson(data));
      await http.post(Uri.parse('$serverHost/update-chat'), headers: {
        'cookie': rawCookie
      }, body: {
        'chat_id': usermsg.chatid,
        'chat_name': json.decode(aires.body)['response']['title']
      });

      chatController.chatList.add(Chat(
        id: chat.id,
        userid: chat.userid,
        name: json.decode(aires.body)['response']['title'],
        createdAt: chat.createdAt,
        updatedAt: chat.updatedAt
      )); 
    }
  }  
}