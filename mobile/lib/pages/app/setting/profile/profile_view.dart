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
          child: Column(
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
                                    child: Obx(() => controller.appController.imageUrl.value.isNotEmpty 
                                      ? Image.network(
                                        controller.supabaseUrl + controller.appController.imageUrl.value,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ) 
                                      : Image.asset(
                                        'assets/image/user-placeholder.png',
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
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
                          child: Obx(() => controller.appController.imageUrl.value.isNotEmpty 
                            ? Image.network(
                              controller.supabaseUrl + controller.appController.imageUrl.value,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ) 
                            : Image.asset(
                              'assets/image/user-placeholder.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: GestureDetector(
                        onTap: () async {
                          await controller.pickImage();
                          
                          if (controller.image.value != null) {
                            showModalBottomSheet(
                              // ignore: use_build_context_synchronously
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              builder: (context) => Obx(() => Container(
                                color: controller.themeController.isDark.value ? Colors.transparent : Colors.white,
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
                                        child: Obx(() {
                                          if (controller.image.value == null) {
                                            Future.delayed(Duration(milliseconds: 300), () {
                                              Navigator.of(context).pop();
                                            });
                                            
                                            return Container(
                                              width: 240,
                                              height: 240,
                                              color: Colors.grey.withOpacity(0.3),
                                              child: Center(
                                                child: Icon(
                                                  Icons.image_not_supported_outlined,
                                                  size: 40,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          }
                                          
                                          return Image.file(
                                            controller.image.value!,
                                            width: 240,
                                            height: 240,
                                            fit: BoxFit.cover,
                                          );
                                        }),
                                      ),
                                    ),

                                    SizedBox(height: 20),

                                    Obx(() => controller.image.value != null 
                                      ? GestureDetector(
                                        onTap: () {
                                          controller.updateImage();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Obx(() => controller.isImageLoading.value ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ) : Text(
                                              'Update',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                      : SizedBox.shrink()
                                    ),
                                  ],
                                ),
                              )),
                            );
                          }
                        },
                        child: Obx(() => Container(
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
                        )),
                      ),
                    ),
                  ],
                ),
              ),
                
              const SizedBox(height: 20),
                
                TextFormField(
                  onChanged: (value) {
                    controller.newName.value = value;
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
                    controller.newEmail.value = value;
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
                  
                Obx(() => controller.newName.value.trim() != controller.name.value.trim() || controller.newEmail.value.trim() != controller.email.value.trim() ?
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.updateInfo();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: controller.isInfoLoading.value ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ) : Text('Update', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))
                    ),
                  )
                ) : const SizedBox(height: 0)),
            ],
          ),
        ),
      ),
    );
  }
}