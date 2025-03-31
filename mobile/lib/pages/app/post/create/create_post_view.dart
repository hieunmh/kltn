import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/post/create/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new post'),
        actions: [
          GestureDetector(
            onTap: () => controller.createPost(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Icon(
                  BoxIcons.bx_paper_plane,
                  size: 28,
                )
              ),
            ),
          )
        ],
        leading: GestureDetector(
          onTap: () => {
            if (controller.postcontentController.text.isNotEmpty || controller.image.value != null) {
              Get.dialog(
                CupertinoAlertDialog(
                title: Text('Warning!'),
                content: Text('Are you sure you want to discard this post?'),
                actions: [
                  CupertinoDialogAction(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      'Discard',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                  ),
                ],
              ),
              )
            } else {
              Get.back()
            }
          },
          child: Icon(
            BoxIcons.bx_chevron_left, 
            size: 32,
          ),
        )
      ),
      body: Obx(() =>
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller.postcontentController,
                  minLines: 1,
                  maxLines: null,
                  cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: controller.themeController.isDark.value ? Colors.grey.shade500 : Colors.grey.shade300,
                        width: 2
                      )
                    ),
                    hintText: 'Write something...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: controller.themeController.isDark.value ? Colors.grey.shade500 : Colors.grey.shade300,
                        width: 2,
                      )
                    )
                  ),
                ),
              ),

              const SizedBox(height: 10),

              controller.image.value != null ?
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        controller.image.value!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: () => controller.image.value = null,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Icon(BoxIcons.bx_x, color: Colors.white),
                        ),
                      ),
                    )
                  )
                ],
                
              ) : SizedBox(),

              const SizedBox(height: 10),

              controller.image.value == null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.themeController.isDark.value ? Colors.white.withAlpha(30) : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(BoxIcons.bxs_camera, color: controller.themeController.isDark.value ? Colors.white : Colors.black),
                          const SizedBox(width: 10),
                          Text('Add an image', style: TextStyle(color: controller.themeController.isDark.value ? Colors.white : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),

              const SizedBox(height: 10),
            ],
          ),
        ),
      )
    );
  }
}