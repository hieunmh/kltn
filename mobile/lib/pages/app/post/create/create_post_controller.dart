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

  final ImagePicker imagePicker = ImagePicker();

  Rx<File?> image = Rx<File?>(null);

  final serverHost = Env.serverhost;

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

    final request = http.MultipartRequest('POST', Uri.parse('$serverHost/create-post'));
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
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post created successfully!'),
          duration: Duration(seconds: 2),
        )
      );
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create post!'),
          duration: Duration(seconds: 2),
        )
      );
    }
  }
}