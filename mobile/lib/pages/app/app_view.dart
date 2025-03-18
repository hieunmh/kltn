import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/pages/app/post/post_view.dart';
import 'package:mobile/pages/app/setting/setting_view.dart';
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
          PostView(),
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
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2_outline),
                  activeIcon: Icon(Iconsax.home_2_bold),
                  label: 'Home'
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