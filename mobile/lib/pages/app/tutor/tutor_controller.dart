import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/theme/theme_controller.dart';

class TutorController extends GetxController {

  ThemeController themeController = Get.find<ThemeController>();

  final serverHost = Env.serverhost;
  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final learnController = TextEditingController(text: '');
}