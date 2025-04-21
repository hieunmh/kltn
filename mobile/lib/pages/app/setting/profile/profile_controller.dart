import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final ThemeController themeController = Get.find<ThemeController>();
  final AppController appController = Get.find<AppController>();
  final serverHost = Env.serverhost;

  final ImagePicker imagePicker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);


  final name = ''.obs;
  final email = ''.obs;

  final newName = ''.obs;
  final newEmail = ''.obs;
  final imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setInfo();
  }

  Future<void> setInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name.value = prefs.getString('name') ?? '';
    newName.value = prefs.getString('name') ?? '';
    email.value = prefs.getString('email') ?? '';
    newEmail.value = prefs.getString('email') ?? '';
  }

  Future<void> pickImage(context) async {
    print('pickImage');
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
    
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) => Container(
        color: themeController.isDark.value ? Colors.transparent : Colors.white,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: Get.width + 50,
        child: Column(
          children: [
            Text(
              'Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.file(
                  image.value!,
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                updateInfo();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateInfo() async {
    print('updateInfo');
  }

}