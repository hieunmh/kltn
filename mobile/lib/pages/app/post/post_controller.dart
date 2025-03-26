import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  final RxList<Post> posts = <Post>[].obs;

  final serverHost = Env.serverhost;

  final ThemeController themeController = Get.find<ThemeController>();
  final AppController appController = Get.find<AppController>();

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    if (commentController.text.isEmpty) {
      return;
    }

    // create comment
    final comment = await http.post(Uri.parse('$serverHost/create-comment'), headers: {
      'cookie': rawCookie
    }, body: {
      'post_id': postid,
      'content': commentController.text,
    });

    if (comment.statusCode == 200 || comment.statusCode == 201) {

      final data = json.decode(comment.body)['comment'];

      comments.add(
        Comment(
          id: data['id'], 
          postid: postid,
          userid: appController.user.value.id, 
          content: data['content'], 
          createdAt: data['createdAt'], 
          updatedAt: data['updatedAt'], 
          user: appController.user.value
        )
      );


      for (var post in posts) {
        if (post.id == postid) {
          post.commentCount += 1;
          posts.refresh();
          break;
        }
      }

      commentController.clear();
    }

  }

}