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
                ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      post: controller.posts[index],
                      color: controller.themeController.isDark.value ? AppColor.bgDarkThemeColor : Colors.white,
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