import 'package:get/get.dart';
import 'package:mobile/pages/app/chat/message/msg_controller.dart';

class MsgBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MsgController>(() => MsgController(), fenix: true);
  }
}