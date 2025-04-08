import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/review/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        scrolledUnderElevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
            height: 0.5
          ),
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.transparent
            ),
          ),
        ),
      ),
      body: Obx(() =>
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
            child: Column(
              children: [
                Center(
                  child: Text(
                    controller.topic.value,
                  ),
                ),
            
                const SizedBox(height: 20),
            
                controller.theory.isEmpty ? Text(
                  'preparing theoretical content...',
                ) : Text(
                  controller.theory.value,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}