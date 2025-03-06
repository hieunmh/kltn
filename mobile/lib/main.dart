import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mobile/routes/pages.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString('user_id') ?? '';

  final initRoute = userid.isEmpty ? AppRoutes.signup : AppRoutes.application;

  runApp(MyApp(initRoute: initRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initRoute});

  final String initRoute;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KLTN',
        getPages: AppPages.pages,
        initialRoute: initRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeController().isDark.value ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
