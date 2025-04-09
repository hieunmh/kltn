import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/tutor/tutor_controller.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/app_color.dart';

class TutorView extends GetView<TutorController> {
  const TutorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Row(
          children: [
           Text(
            'Tutor AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4a66f0)
            ),
           )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
            height: 0.5
          ),
        ),
      ),
      backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
      body: Obx(() =>
        SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  Text(
                    'Welcome to Tutor AI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4a66f0)
                    ),
                  ),
        
                  const SizedBox(height: 20),
        
                  Text(
                    'Bạn muốn học chủ đề gì hôm nay?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
        
                  const SizedBox(height: 20),
        
                  TextField(
                    controller: controller.learnController,
                    minLines: 1,
                    maxLines: null,
                    cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                    onChanged: (value) {
                      controller.learnText.value = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        BoxIcons.bx_search,
                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                          width: 0.5
                        )
                      ),
                      fillColor: controller.themeController.isDark.value ? Colors.white.withAlpha(10) : Colors.white,
                      filled: true,
                      hintText: 'Ví dụ: Học về lập trình Flutter',
                      hintStyle: TextStyle(
                        color: controller.themeController.isDark.value ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                          width: 0.5,
                        )
                      )
                    ),
                  ),

                  const SizedBox(height: 5),

                  controller.learnTextError.isNotEmpty ? SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: Text(
                      controller.learnTextError.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ) : const SizedBox(height: 20),
        
                  const SizedBox(height: 5),

                  GestureDetector(
                    onTap: () {
                      // controller.getVoice();
                      if (controller.learnText.isEmpty) {
                        controller.learnTextError.value = 'Vui lòng nhập chủ đề bạn muốn học';
                        return;
                      }
                      Get.toNamed(AppRoutes.review, arguments: {
                        'topic': controller.learnController.text,
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: controller.learnText.isEmpty ? Colors.transparent : Color(0xFF4a66f0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFF4a66f0),
                          width: 2
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(BoxIcons.bxs_graduation, color: controller.learnText.isEmpty ? Color(0xff4a66f0) : Colors.white, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: controller.learnText.isEmpty ? Color(0xff4a66f0) : Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: controller.themeController.isDark.value ? Colors.white.withAlpha(30) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                          width: 0.5
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesome.bolt_lightning_solid, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            'Gợi ý chủ đề',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}