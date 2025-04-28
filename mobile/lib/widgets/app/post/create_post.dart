import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/post/create/create_post_controller.dart';
import 'package:icons_plus/icons_plus.dart';
class CreatePost extends StatelessWidget {

  final CreatePostController controller = Get.put(CreatePostController());

  CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: Get.width,
      height: Get.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controller.postcontentController,
                focusNode: controller.focusNode,
                minLines: 1,
                maxLines: null,
                cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Write something...',
                  enabledBorder: InputBorder.none,
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
                    borderRadius: BorderRadius.circular(10),
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
          ],
        ),
      ),
    );
  }
}