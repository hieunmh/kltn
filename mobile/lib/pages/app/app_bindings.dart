import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/pages/app/chat/chat_controller.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/pages/app/setting/setting_controller.dart';
import 'package:mobile/pages/app/voice/voice_controller.dart';
import 'package:mobile/theme/theme_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => VoiceController());
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => ChatController());
  }
}