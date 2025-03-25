import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/post/post_widget.dart';
import 'package:icons_plus/icons_plus.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor.withAlpha(120) : Colors.white.withAlpha(120),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Posts',
                style: TextStyle(
                  fontWeight: FontWeight.w700,  
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.toNamed('/post/create');
            },
            icon: Icon(BoxIcons.bx_add_to_queue),
            iconSize: 24,
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
            height: 0.5
          ),
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.transparent
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : AppColor.bgLightThemeColor,
              ),
              height: Get.height - 90,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Obx(() =>
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                    thickness: 0.5,
                  ),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      post: controller.posts[index],
                      color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                      ontap: () => {
                        controller.getCommentByPost(controller.posts[index].id),
                        Get.bottomSheet(
                          Container(
                            height: Get.height / 2, // Đặt chiều cao bằng 1/2 màn hình
                            decoration: BoxDecoration(
                              color: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return controller.isLoadingComment.value ? Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ) : controller.comments.isEmpty ? Expanded(
                                    child: Center(
                                      child: Text(
                                        'No comments',
                                        style: TextStyle(
                                          color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ) : Expanded( // Giúp ListView hiển thị đúng
                                    child: ListView.builder(
                                      reverse: true,
                                      itemCount: controller.comments.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(controller.comments[index].content),
                                          subtitle: Text(controller.comments[index].createdAt),
                                        );
                                      },
                                    ),
                                  );
                                }),

                                Container(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Iconsax.add_circle_bold),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: TextField(
                                          controller: controller.commentController,
                                          cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                          decoration: InputDecoration(
                                            hintText: 'Type a message',
                                            hintStyle: TextStyle(color: Colors.grey.shade400),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          controller.createComment(controller.posts[index].id);
                                        },
                                        child: Icon(Iconsax.send_1_bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isScrollControlled: true, // Cho phép bottom sheet mở rộng theo nội dung
                        )
                      },
                    );
                  },
                ),
              ),
            )
          ],
        )
      )
    );
  }
}