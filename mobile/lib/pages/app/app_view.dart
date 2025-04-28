import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/pages/app/chat/chat_view.dart';
import 'package:mobile/pages/app/post/post_view.dart';
import 'package:mobile/pages/app/setting/setting_view.dart';
import 'package:mobile/pages/app/tutor/tutor_view.dart';
import 'package:mobile/theme/app_color.dart';

class AppView extends GetView<AppController> {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value) => controller.changePage(value),
        children: [
          TutorView(),
          PostView(),
          ChatView(),
          SettingView()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5
            )
          )
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent
          ), 
          child: Obx(() =>
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              unselectedItemColor: Colors.grey,
              selectedItemColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.ghost_outline),
                  activeIcon: Icon(Iconsax.ghost_bold),
                  label: 'Review AI'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.receipt_outline),
                  activeIcon: Icon(Iconsax.receipt_1_bold),
                  label: 'Q&A'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.message_text_outline),
                  activeIcon: Icon(Iconsax.message_text_1_bold),
                  label: 'Chat'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.setting_outline),
                  activeIcon: Icon(Iconsax.setting_bold),
                  label: 'Setting'
                ),
              ],
              currentIndex: controller.currentPage.value,
              onTap: (value) => controller.handleNavBarTap(value),
            ),
          )
        ),
      ),
    );
  }
}