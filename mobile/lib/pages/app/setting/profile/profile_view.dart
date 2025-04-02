import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                GestureDetector(
                  onTap: () => {
                    // print(controller.nameController.text != controller.name.value)
                  },
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        controller.supabaseUrl + controller.appController.imageUrl.value,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
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