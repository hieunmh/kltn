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
  RxString chatId = ''.obs;
  RxBool isAIresponding = false.obs;
  final RxString model = ''.obs;

  @override
  void onInit() {
    super.onInit(); 
    model.value = Get.arguments['model'] ?? 'geminiai';
    if (Get.arguments['message'] != null) {
      messages.add(Get.arguments['message'] as Message); 
      createAiMessage();
    } else {
      chatId.value = Get.arguments['chat_id'];
      getChatMessage(Get.arguments['chat_id']);
    }
  }

  @override
  void onClose() {
    // Xóa bộ nhớ khi controller bị hủy
    msgController.dispose();
    super.onClose();
  }

  Future<void> createAiMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final usermsg = Get.arguments['message'] as Message;
    final chat = Get.arguments['chat'] as Chat;

    isAIresponding.value = true;

    // get AI response

    final aires = model.value == 'geminiai' ?  await http.post(Uri.parse('$serverHost/gemini_ai'), body: {
      'text': usermsg.message,
      'model': Env.geminiModel
    }) : 
    await http.post(Uri.parse('$serverHost/open_ai'), body: {
      'text': usermsg.message,
      'model': Env.openaiModel
    });

    print(aires.body);

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
      messages.refresh();
      await http.patch(Uri.parse('$serverHost/update-chat'), headers: {
        'cookie': rawCookie
      }, body: {
        'chat_id': usermsg.chatid,
        'chat_name': json.decode(aires.body)['response']['title']
      });
      
      isAIresponding.value = false;

      // Đảm bảo chatId đã được thiết lập
      if (chatId.value.isEmpty) {
        chatId.value = usermsg.chatid;
      }

      chatController.chatList.add(Chat(
        id: chat.id,
        userid: chat.userid,
        name: json.decode(aires.body)['response']['title'],
        createdAt: chat.createdAt,
        updatedAt: chat.updatedAt
      )); 
    }
  }  

  Future<void> getChatMessage(chatid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final chatmsg = await http.get(Uri.parse('$serverHost/get-chat-by-id?chat_id=$chatid'), headers: {
      'cookie': rawCookie
    });

    if (chatmsg.statusCode == 200) {
      final msgs = json.decode(chatmsg.body)['chat']['messages'] as List;
      
      messages.value = msgs.map((p) {
        final messageData = Map<String, dynamic>.from(p); 
        messageData['chat_id'] = chatid; 

        return Message.fromJson(messageData); 
      }).toList();
    }
  }

  Future<void> createMessage() async {
    print('createMessage');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    if (msgController.text.isEmpty) {
      return;
    }

    final usertext = msgController.text;

    // create user message
    final usermsg = await http.post(Uri.parse('$serverHost/create-message'), headers: {
      'cookie': rawCookie
    }, body: {
      'chat_id': chatId.value,
      'role': 'user',
      'message': usertext,
    });

    if (usermsg.statusCode == 200 || usermsg.statusCode == 201) {
      final data = json.decode(usermsg.body)['message'] as Map<String, dynamic>;
      messages.add(Message.fromJson(data));
      messages.refresh();
      msgController.clear();
    }

    isAIresponding.value = true;

    //  get AI response
    final aires = model.value == 'geminiai' ?  await http.post(Uri.parse('$serverHost/gemini_ai'), body: {
      'text': usertext,
      'model': Env.geminiModel,
      'history': messages.where((m) => m.role == 'user').map((m) => '${m.role}: ${m.message}\n').toList().join(' ')
    }) : 
    await http.post(Uri.parse('$serverHost/open_ai'), body: {
      'text': usertext,
      'model': Env.openaiModel,
      'history': messages.where((m) => m.role == 'user').map((m) => '${m.role}: ${m.message}\n').toList().join(' ')
    });

    // creaste AI message
    final aimsg = await http.post(Uri.parse('$serverHost/create-message'), headers: {
      'cookie': rawCookie
    }, body: {
      'role': 'assistant',
      'chat_id': chatId.value,
      'message': json.decode(aires.body)['response']['content']
    });

    if (aimsg.statusCode == 200 || aimsg.statusCode == 201) {
      final data = json.decode(aimsg.body)['message'] as Map<String, dynamic>;
      messages.add(Message.fromJson(data));
      isAIresponding.value = false;
    }
  }
}