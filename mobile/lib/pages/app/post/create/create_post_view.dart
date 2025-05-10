import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/post/create/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0.0,
              backgroundColor: controller.themeController.isDark.value ? Colors.grey.shade900.withAlpha(120) : Colors.white.withAlpha(120),
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => controller.createPost(context),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Obx(() =>
                      Container(
                        height: 30,
                        width: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          color: controller.postcontent.value.trim().isNotEmpty || controller.image.value != null ?  Colors.blue : controller.themeController.isDark.value ? Colors.white.withAlpha(30) : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: controller.isPosting.value ? SizedBox(
                            width: 15,
                            height: 15,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2
                            ),
                          ) : Text(
                            'Post', 
                            style: TextStyle(
                              color: controller.postcontent.value.trim().isNotEmpty || controller.image.value != null ? Colors.white : controller.themeController.isDark.value ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            )
                          ),  
                        ),
                      ),
                    ),
                  ),
                )
              ],
              leadingWidth: 85,
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
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                )
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
                  height: 0.5
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Obx(() =>
                        TextField(
                          onChanged: (value) {
                            controller.postcontent.value = value;
                          },
                          controller: controller.postcontentController,
                          minLines: 1,
                          maxLines: null,
                          focusNode: controller.focusNode,
                          cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            hintText: 'Write something...',
                            hintStyle: TextStyle(
                              color: controller.themeController.isDark.value ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100),
                            ),
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                          
                    Obx(() => 
                    controller.image.value != null ?
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                      ) : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesome.images, color: controller.themeController.isDark.value ? Colors.white : Colors.black, size: 20),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}