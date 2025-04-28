import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/routes/routes.dart';
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
        title: const Row(
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
              Get.toNamed(AppRoutes.createpost);
            },
            icon: const Icon(BoxIcons.bx_add_to_queue),
            iconSize: 24,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
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
              decoration: const BoxDecoration(),
              height: Get.height - 90,
              width: double.infinity,
              padding: EdgeInsets.zero,
              child: Obx(() {
                if (controller.posts.isEmpty) {
                  return  Center(
                    child: Text(
                      'No posts available',
                      style: TextStyle(
                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) =>Divider(
                    color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                    thickness: 0.5,
                  ),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      deletePost: controller.deletePost,
                      themeController: controller.themeController,
                      supabaseUrl: controller.supabaseUrl,
                      post: controller.posts[index],
                      color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
                      userid: controller.appController.userid.value,
                      currentUserImage: controller.appController.imageUrl.value,
                      currentUserName: controller.appController.name.value,
                      ontap: () => {
                        Get.bottomSheet(
                          SafeArea(
                            child: Container(
                              height: Get.height * 0.55,
                              decoration: BoxDecoration(
                                color: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Center(
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
                                    if (controller.posts[index].comments.isEmpty) {
                                      return Expanded(
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
                                      );
                                    }
                                    
                                    return Expanded(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                        child: GroupedListView(
                                          elements: controller.posts[index].comments,
                                          groupBy: (comment) => comment.createdAt,
                                          groupSeparatorBuilder: (comment) => const SizedBox(height: 15),
                                          order: controller.posts[index].comments.length > 5 ? GroupedListOrder.DESC : GroupedListOrder.ASC, 
                                          reverse: controller.posts[index].comments.length > 5 ? true : false,
                                          useStickyGroupSeparators: false,
                                          floatingHeader: false,
                                          itemBuilder: (context, comment) {
                                            if (comment.user.id == controller.appController.userid.value) {
                                              return Slidable(
                                                key: ValueKey(comment.id),
                                                endActionPane: ActionPane(
                                                  motion: const ScrollMotion(), 
                                                  extentRatio: 0.25,
                                                  children: [                                              
                                                    SlidableAction(
                                                      onPressed: (context) {
                                                        Slidable.of(context)?.close();
                                                        showCupertinoModalPopup(
                                                          context: context, 
                                                          builder: (context) => CupertinoActionSheet(
                                                            title: const Text(
                                                              'Are you sure to delete this comment?',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                            actions: [
                                                              CupertinoActionSheetAction(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  controller.deleteComment(comment.id, controller.posts[index].id);
                                                                },
                                                                child: const Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                    color: Colors.red,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                            cancelButton: CupertinoActionSheetAction(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: const Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                    color: Colors.blue,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w700
                                                                  ),
                                                                ),
                                                            ),
                                                          )
                                                        );
                                                      },
                                                      icon: BoxIcons.bx_trash,
                                                      backgroundColor: Colors.red,
                                                      foregroundColor: Colors.white,
                                                    )
                                                  ]
                                                ),
                                                child: CommentBox(
                                                  currentUserImage: controller.appController.imageUrl.value,
                                                  comment: comment,
                                                  userid: controller.appController.userid.value,
                                                  supabaseUrl: controller.supabaseUrl,
                                                  currentUserName: controller.appController.name.value,
                                                ),
                                              );
                                            }
                                            return CommentBox(
                                              currentUserImage: controller.appController.imageUrl.value,
                                              comment: comment,
                                              userid: controller.appController.userid.value,
                                              supabaseUrl: controller.supabaseUrl,
                                              currentUserName: controller.appController.name.value,
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),

                                  Obx(() => Container(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    decoration: BoxDecoration(
                                      color: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: controller.themeController.isDark.value ? Colors.grey.shade800 : Colors.grey.shade300,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        controller.appController.imageUrl.isNotEmpty 
                                          ? Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.grey.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.network(
                                                  controller.supabaseUrl + controller.appController.imageUrl.value,
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ) : Container(
                                              width: 40, 
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle, 
                                                border: Border.all( 
                                                  color: Colors.grey.shade400, 
                                                  width: 1,
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
                                                const Icon(Iconsax.add_circle_bold),
                                                const SizedBox(width: 10),
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
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.createComment(controller.posts[index].id);
                                                  },
                                                  child: const Icon(Iconsax.send_1_bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
                          isScrollControlled: true,
                        ).then((value) {
                          controller.commentController.clear();
                        })
                      },
                    );
                  },
                );
              }),
            )
          ],
        )
      )
    );
  }
}