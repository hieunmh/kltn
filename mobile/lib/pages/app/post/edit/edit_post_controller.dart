import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/pages/app/post/post_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class EditPostController extends GetxController {
  final postController = Get.find<PostController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final RxBool isUpdating = false.obs;

  final postid = ''.obs;
  final postContent = ''.obs;
  final postImageurl = ''.obs;
  final deleteImagePath = ''.obs;

  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';

  final serverHost = Env.serverhost;

  final FocusNode focusNode = FocusNode();
  final postcontentController = TextEditingController();  

  final ImagePicker imagePicker = ImagePicker();

  final post = Post(
    id: '',
    userid: '',
    subject: '',
    content: '',
    imageUrl: '',
    createdAt: '',
    updatedAt: '',
    user: User(
      id: '',
      name: '',
      email: '',
      imageUrl: '',
    ),
    comments: []
  ).obs;


  Rx<File?> image = Rx<File?>(null);
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    postid.value = Get.arguments['postid'];
    postContent.value = Get.arguments['postcontent'];
    postImageurl.value = Get.arguments['postimageurl'];
    deleteImagePath.value = Get.arguments['postimageurl'];
    post.value = Get.arguments['post'];
    postcontentController.text = post.value.content;
  }

  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> editPost(BuildContext context) async  {
    final imageFile = image.value;

    if (postcontentController.text.isEmpty) {
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

    isUpdating.value = true;

    final request = http.MultipartRequest('PATCH', Uri.parse('$serverHost/post/update-post'));
    request.headers['cookie'] = rawCookie;
    request.fields['content'] = postcontentController.text;
    request.fields['post_id'] = postid.value;
    request.fields['image_path'] = deleteImagePath.value;

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
      final updatedPost = Post(
        id: post.value.id,
        userid: post.value.userid,
        subject: post.value.subject,
        content: postres['content'],
        imageUrl: postres['image_url'],
        createdAt: post.value.createdAt,
        updatedAt: post.value.updatedAt,
        user: post.value.user,
        comments: post.value.comments
      );

      postController.posts[postController.posts.indexWhere((post) => post.id == postid.value)] = updatedPost;
      postController.filterPosts[postController.filterPosts.indexWhere((post) => post.id == postid.value)] = updatedPost;
      Get.back();
      Get.snackbar(
        'Success',
        'Post updated successfully!',
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
          content: Text('Failed to update post!'),
          duration: Duration(seconds: 2),
        )
      );
    }

    isUpdating.value = false;

  }
}
