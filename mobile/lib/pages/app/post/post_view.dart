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
import 'package:dropdown_button2/dropdown_button2.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            scrolledUnderElevation: 0.0,
            backgroundColor: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white,
            title: Row(
              children: [
                Obx(() =>
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: controller.items.map(
                        (item) => DropdownMenuItem<String>(
                          value: item, 
                          child: Text(
                            item, 
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                            )
                          ))
                        ).toList(),
                      onChanged: (value) {
                        controller.selectPost(value ?? '');
                      },
                      value: controller.selected.value,
                      menuItemStyleData: MenuItemStyleData(
                        padding: EdgeInsets.only(left: 10, right: 0), 
                       
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: controller.themeController.isDark.value ? Colors.grey.shade900 : Colors.white, // Màu nền đỏ cho dropdown
                          borderRadius: BorderRadius.circular(8.0), // Bo góc nếu cần
                        ),
                        maxHeight: 200, // Chiều cao tối đa của dropdown (tùy chọn)
                      ),
                    )
                  ),
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.createpost);
                  },
                  child: const Icon(BoxIcons.bx_add_to_queue, size: 24),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400, 
                height: 0.5
              ),
            ),
          ),
          Obx(() {
            if (controller.postLoading.value) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height - Get.bottomBarHeight - Get.statusBarHeight,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              );
            }
            if (controller.filterPosts.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    height: Get.height - Get.bottomBarHeight - Get.statusBarHeight, // Chiều cao của màn hình
                    alignment: Alignment.center, // Căn giữa theo chiều dọc
                    child: Text(
                      'Không có bài viết',
                      style: TextStyle(
                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      PostWidget(
                        deletePost: controller.deletePost,
                        themeController: controller.themeController,
                        supabaseUrl: controller.supabaseUrl,
                        post: controller.filterPosts[index],
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
                                          'Bình luậln',
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
                                              'Bình luận đầu tiên',
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
                                                    extentRatio: 0.5,
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          controller.showEditComment(comment.content, comment.id, comment.createdAt);                           
                                                        },
                                                        icon: BoxIcons.bx_edit,
                                                        backgroundColor: Colors.blue,
                                                        foregroundColor: Colors.white,
                                                      ),
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          Slidable.of(context)?.close();
                                                          showCupertinoModalPopup(
                                                            context: context,
                                                            builder: (context) => CupertinoActionSheet(
                                                              title: const Text(
                                                                'Bạn có chắc chắn muốn xóa bình luận này không?',
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
                                                                    'Xóa',
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
                                                                  'Hủy',
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
                                          controller.appController.imageUrl.isNotEmpty ? Container(
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
                                                      focusNode: controller.focusNode,
                                                      cursorColor: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                                      decoration: InputDecoration(
                                                        hintText: 'Bình luận cho ${controller.posts[index].user.name}',
                                                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                                        border: InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (controller.isEdit.value) {
                                                        controller.editComment(controller.posts[index].id);
                                                      } else {
                                                        controller.createComment(controller.posts[index].id);
                                                      }
                                                    },
                                                    child: controller.isLoading.value ? SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        color: controller.themeController.isDark.value ? Colors.white : Colors.black,
                                                        strokeWidth: 2.5,
                                                      ),
                                                    ) : controller.isEdit.value ? 
                                                    const Icon(Iconsax.send_2_bold) : 
                                                    const Icon(Iconsax.send_1_bold),
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
                            controller.isEdit.value = false;
                          })
                        },
                      ),
                      if (index < controller.filterPosts.length - 1)
                        Divider(
                          color: controller.themeController.isDark.value ? Colors.grey.shade700 : Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                    ],
                  );
                },
                childCount: controller.filterPosts.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}