import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  final RxList<Post> posts = <Post>[].obs;

  final serverHost = Env.serverhost;

  final ThemeController themeController = Get.find<ThemeController>();

  final commentController = TextEditingController();

  final RxList<Comment> comments = <Comment>[].obs;
  final RxBool isLoadingComment = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  Future<void> getPostList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final postlist = await http.get(Uri.parse('$serverHost/get-post-by-condition'), headers: {
      'cookie': rawCookie
    });
    if (postlist.statusCode == 200) {
      final data = json.decode(postlist.body)['posts'] as List;
      posts.value = data.map((p) => Post.fromJson(p as Map<String, dynamic>)).toList();
    }
  }

  Future<void> getCommentByPost(String postid) async {
    comments.value = [];
    isLoadingComment.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final commentlist = await http.get(Uri.parse('$serverHost/get-comment-by-post?post_id=$postid'), headers: {
      'cookie': rawCookie
    });
    isLoadingComment.value = false;

    if (commentlist.statusCode == 200) {
      final data = json.decode(commentlist.body)['comments'] as List;
      comments.value = data.map((p) => Comment.fromJson(p as Map<String, dynamic>)).toList();
    }
  }

  Future<void> createComment(String postid) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final rawCookie = prefs.getString('cookie') ?? '';

    // // create comment
    // await http.post(Uri.parse('$serverHost/create-comment'), headers: {
    //   'cookie': rawCookie
    // }, body: {
    //   'post_id': postid,
    //   'content': commentController.text,
    // });
    print(postid);
  }

}