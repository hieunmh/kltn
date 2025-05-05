import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/tutor/review/review_controller.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        // toolbarHeight: 0.0,
      ),
      body: Obx(() =>
        Column(
          children: [                        
            Expanded(
              child: controller.theory.isEmpty ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: LoadingIndicator(
                        colors: controller.themeController.isDark.value ? [Colors.white] : [Colors.black],
                        strokeWidth: 1,
                        indicatorType: Indicator.lineScale,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 16,
                        color: controller.themeController.isDark.value ? Colors.white : Colors.black
                      ),
                    )
                  ],
                )
            ) : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: SingleChildScrollView(
                        child: Text(
                          controller.theory.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.themeController.isDark.value ? Colors.white : Colors.black
                          ),
                        ),
                      ),
                    )
                  ),

                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
                      border: Border(
                        top: BorderSide(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
                          width: 0.5
                        )
                      ) 
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.voice, arguments: {
                                'theory': controller.theory.value
                              });
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
                                  width: 1
                                ),
                                color: controller.themeController.isDark.value ? Colors.white.withAlpha(30) : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Start testing',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: controller.themeController.isDark.value ? Colors.white : Colors.black
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}