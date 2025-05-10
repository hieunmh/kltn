// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CreatePostController extends GetxController {
  final postcontentController = TextEditingController();

  final ThemeController themeController = Get.find<ThemeController>();
  final PostController postController = Get.find<PostController>();
  final RxBool isPosting = false.obs;
  final postcontent = ''.obs;

  final ImagePicker imagePicker = ImagePicker();
  final FocusNode focusNode = FocusNode();

  Rx<File?> image = Rx<File?>(null);

  final serverHost = Env.serverhost;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> createPost(BuildContext context) async {
    final postcontent = postcontentController.text;
    final imageFile = image.value;

    if (postcontent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post content cannot be empty!'),
          duration: Duration(seconds: 2),
        )
      );
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';
    isPosting.value = true;
    final request = http.MultipartRequest('POST', Uri.parse('$serverHost/post/create-post'));
    request.headers['cookie'] = rawCookie;
    request.fields['content'] = postcontent;
    request.fields['subject'] = 'subject';
    request.fields['title'] = 'title';
    
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
        'post_image', imageFile.path, contentType: MediaType.parse(lookupMimeType(imageFile.path)!)
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final postres = json.decode(response.body)['post'];
      final newPost = Post(
        id: postres['id'], 
        userid: postController.appController.userid.value, 
        subject: postres['subject'], 
        content: postres['content'],
        imageUrl: postres['image_url'],
        createdAt: postres['createdAt'],
        updatedAt: postres['updatedAt'],
        user: postController.appController.user.value,
        comments: []
      );

      postController.posts.insert(0, newPost);
      postController.filterPosts.insert(0, newPost);
      Get.back();
      Get.snackbar(
        'Success',
        'Post created successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey[850],
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create post!'),
          duration: Duration(seconds: 2),
        )
      );
    }

    isPosting.value = false;
  }
}