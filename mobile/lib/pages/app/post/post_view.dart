import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/widgets/app/post/post_widget.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
          ),
          child: Obx(() =>
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: controller.posts[index]);
              },
            
            ),
          ),
        )
      )
    );
  }
}