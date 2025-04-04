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
                        onTap: () => {
                          print(1)
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
                            child: Image.network(
                              controller.supabaseUrl + controller.appController.imageUrl.value,
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
                            print(2);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              BoxIcons.bxs_pencil,
                              color: Colors.white,
                              size: 24
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  
                const SizedBox(height: 20),
                
                Container(
                  child: TextFormField(
                    onChanged: (value) {
                      controller.name.value = value;
                    },
                    initialValue: controller.appController.name.value,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  
                const SizedBox(height: 20),

                Container(
                  child: TextFormField(
                    onChanged: (value) {
                      controller.email.value = value;
                    },
                    initialValue: controller.appController.email.value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
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