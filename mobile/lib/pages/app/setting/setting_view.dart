import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/setting/setting_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/setting/id_setting.dart';
import 'package:mobile/widgets/app/setting/profile_setting.dart';
import 'package:mobile/widgets/app/setting/signout_setting.dart';
import 'package:mobile/widgets/app/setting/theme_setting.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
        appBar: AppBar(
        backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor.withAlpha(120) : Colors.white.withAlpha(120),
        title: Row(
          children: [
            Text(
              'Setting',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,  
              ),
            ),
          ],
        ),
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
        backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                  border: Border.all(
                    color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                    width: 0.5
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ProfileSetting(name: controller.appController.name.value),
                
                    const SizedBox(height: 5),
                
                    IdSetting(id: controller.appController.userid.value),
                
                    const SizedBox(height: 5),
                
                    ThemeSetting(
                      isDarkMode: controller.themeController.isDark.value,
                      setDarkTheme: (value) => controller.themeController.changeTheme(value),
                    ),
                    
                    const SizedBox(height: 5),
                
                    SignoutSetting(signout: controller.signout),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}