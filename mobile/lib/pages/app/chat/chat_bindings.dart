import 'package:get/get.dart';
import 'package:mobile/pages/app/chat/chat_controller.dart';
import 'package:mobile/pages/app/chat/message/msg_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut(() => MsgController());
  }
}