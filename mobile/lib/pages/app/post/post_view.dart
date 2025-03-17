import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/widgets/app/post/post_widget.dart';
import 'package:icons_plus/icons_plus.dart';

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
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Get.toNamed('/post/create');
                    },
                    icon: Icon(BoxIcons.bx_add_to_queue),
                    iconSize: 24,
                  )
                ],
              ),
            ),

            Container(
              height: Get.height - 200,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Obx(() =>
                ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(post: controller.posts[index]);
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