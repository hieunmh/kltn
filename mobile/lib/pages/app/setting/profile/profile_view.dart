import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/setting/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Obx(() =>
            Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(
                                    color: Colors.black,
                                    child: Center(
                                      child: controller.appController.imageUrl.value.isNotEmpty ? Image.network(
                                        controller.supabaseUrl + controller.appController.imageUrl.value,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ) : Image.asset(
                                        'assets/image/user-placeholder.png',
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    right: 20,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: controller.appController.imageUrl.value.isNotEmpty ? Image.network(
                              controller.supabaseUrl + controller.appController.imageUrl.value,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ) : Image.asset(
                              'assets/image/user-placeholder.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 3,
                        child: GestureDetector(
                          onTap: () {
                            controller.pickImage(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: controller.themeController.isDark.value ? Colors.white.withAlpha(150) : Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              BoxIcons.bxs_pencil,
                              color: controller.themeController.isDark.value ? Colors.black : Colors.white,
                              size: 24
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  
                const SizedBox(height: 20),
                
                TextFormField(
                  onChanged: (value) {
                    controller.name.value = value;
                  },
                  initialValue: controller.appController.name.value,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                  
                const SizedBox(height: 20),
                
                TextFormField(
                  onChanged: (value) {
                    controller.email.value = value;
                  },
                  initialValue: controller.appController.email.value,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  
                ),
                  
                const SizedBox(height: 20),
                  
                controller.newName.value != controller.name.value || controller.newEmail.value != controller.email.value ?
                ElevatedButton(
                  onPressed: () {
                    // controller.updateProfile();
                  },
                  child: const Text('Update'),
                ) : const SizedBox(height: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}