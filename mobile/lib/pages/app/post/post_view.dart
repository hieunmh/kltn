import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/theme/app_color.dart';
import 'package:mobile/widgets/app/post/post_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/widgets/app/post/comment_box.dart';
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
                            height: Get.height * 0.55,
                            decoration: BoxDecoration(
                              color: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: double.infinity, 
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Comments',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),

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
                                        'Be the first to comment',
                                        style: TextStyle(
                                          color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ) : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                      child: GroupedListView(
                                        // ignore: invalid_use_of_protected_member
                                        elements: controller.comments.value, 
                                        groupBy: (comment) => comment.createdAt,
                                        groupSeparatorBuilder: (comment) => SizedBox(height: 15),
                                        order: GroupedListOrder.DESC,
                                        reverse: false,
                                        itemBuilder: (context, element) {
                                          return CommentBox(
                                            comment: element,
                                            userid: controller.appController.userid.value,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),

                                Container(
                                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      controller.appController.imageUrl.isNotEmpty ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          controller.appController.imageUrl.value, 
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        )                          
                                      ) : Container(
                                        width: 40, 
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle, 
                                          border: Border.all( 
                                            color: Colors.grey.shade400, 
                                            width: 1.5,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.asset(
                                            'assets/image/user-placeholder.png',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(40)
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
                                                    hintText: 'Comment for ${controller.posts[index].user.name}',
                                                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
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
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isScrollControlled: true,
                        ).then((value) {
                          controller.commentController.clear();
                        })
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