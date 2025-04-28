import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/app/post/edit/edit_post_controller.dart';

class EditPostView extends GetView<EditPostController> {
  const EditPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Text('Edit Post'),
    );
  }
}