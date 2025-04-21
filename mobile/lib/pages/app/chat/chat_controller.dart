import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/env.dart';
import 'package:mobile/models/chat.dart';
import 'package:mobile/models/message.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {

  final RxList<Chat> chatList = <Chat>[].obs;

  final serverHost = Env.serverhost;

  final ThemeController themeController = Get.find<ThemeController>();

  RxString model = Env.geminiModel.obs;
  final msgController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    getAllChat();
  }

  Future<void> getAllChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final chat = await http.get(Uri.parse('$serverHost/get-all-chat'), headers: {
      'cookie': rawCookie
    });

    if (chat.statusCode == 404) {
      chatList.value = [];
    } else if (chat.statusCode == 200) {
      final data = json.decode(chat.body)['chats'] as List;
      chatList.value = data.map((p) => Chat.fromJson(p as Map<String, dynamic>)).toList();
    }
  }

  Future<void> createChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    if (msgController.text.isEmpty) {
      return;
    }
    
    // create chat
    final chat = await http.post(Uri.parse('$serverHost/create-chat'), headers: {
      'cookie': rawCookie
    }, body: {
      'chat_name': ''
    });
    
    // create user message
    final usermsg = await http.post(Uri.parse('$serverHost/create-message'), headers: {
      'cookie': rawCookie
    }, body: {
      'chat_id': json.decode(chat.body)['chat']['id'].toString(),
      'role': 'user',
      'message': msgController.text,
    });

    Get.back();

    Get.toNamed(
      AppRoutes.message, 
      arguments: {
        'message': Message(
          id: json.decode(usermsg.body)['message']['id'], 
          chatid: json.decode(usermsg.body)['message']['chat_id'], 
          role: 'user',
          message: json.decode(usermsg.body)['message']['message'], 
          updatedAt: json.decode(usermsg.body)['message']['updatedAt'], 
          createdAt: json.decode(usermsg.body)['message']['createdAt']
        ),
        'chat': Chat(
          id: json.decode(chat.body)['chat']['id'].toString(),
          userid: json.decode(chat.body)['chat']['user_id'].toString(),
          name: json.decode(chat.body)['chat']['name'],
          createdAt: json.decode(chat.body)['chat']['createdAt'],
          updatedAt: json.decode(chat.body)['chat']['updatedAt']
        ) 
      }
    );
  }

  void getChatMessage(String chatid, String chatName) async {
    Get.toNamed(AppRoutes.message, arguments: {
      'chat_id': chatid,
      'chat_name': chatName
    });
  }

  Future<void> deleteChat(String chatid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final chat = await http.delete(Uri.parse('$serverHost/delete-chat'), 
      headers: { 'cookie': rawCookie },
      body: { 'chat_id': chatid }
    );

    if (chat.statusCode == 200) {
      chatList.removeWhere((chat) => chat.id == chatid);
    }
    
  }
}