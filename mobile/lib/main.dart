import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/routes/pages.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'KLTN',
        getPages: AppPages.pages,
        initialRoute: AppRoutes.signin,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeController().isDark.value ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
