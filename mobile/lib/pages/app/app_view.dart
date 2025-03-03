import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/app_controller.dart';

class AppView extends GetView<AppController> {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() =>
        Column(
          children: [
            Text(
              controller.userid.value
            ),
            Text(
              controller.email.value
            ),
            Text(
              controller.name.value
            ),
          ],
        ),
      )
    );
  }
}