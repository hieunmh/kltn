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
  final RxList<Post> filterPosts = <Post>[].obs;

  final serverHost = Env.serverhost;
  final supabaseUrl = '${Env.supabaseUrl}/storage/v1/object/public/';
  

  final ThemeController themeController = Get.find<ThemeController>();
  final AppController appController = Get.find<AppController>();

  final commentController = TextEditingController();
  final postLoading = true.obs;

  final selected = 'All posts'.obs;

  final RxList<String> items = [
    'All posts',
    'Your posts',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  void selectPost(String selected) {
    this.selected.value = selected;
    if (selected == 'Your posts') {
      filterPosts.value = posts.where((post) => post.userid == appController.user.value.id).toList();
    } else {
      filterPosts.value = posts;
    }
  }

  Future<void> getPostList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    postLoading.value = true;
    final postlist = await http.get(Uri.parse('$serverHost/post/get-post-by-condition'), headers: {
      'cookie': rawCookie
    });
    if (postlist.statusCode == 200) {
      final data = json.decode(postlist.body)['posts'] as List;
      posts.value = data.map((p) => Post.fromJson(p as Map<String, dynamic>)).toList();
      filterPosts.value = data.map((p) => Post.fromJson(p as Map<String, dynamic>)).toList();
    }
    postLoading.value = false;
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

      posts.firstWhere((element) => element.id == postid).comments.add(
        Comment(
          id: data['id'],
          postid: data['post_id'],
          userid: data['user_id'],
          content: data['content'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
          user: appController.user.value
        )
      );
      filterPosts.firstWhere((element) => element.id == postid).comments.add(
        Comment(
          id: data['id'],
          postid: data['post_id'],
          userid: data['user_id'],
          content: data['content'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
          user: appController.user.value
        )
      );
      posts.refresh();
      filterPosts.refresh();

      commentController.clear();
    }
  }

  Future<void> deleteComment(String commentid, String postid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final comment = await http.delete(Uri.parse('$serverHost/delete-comment'), headers: {
      'cookie': rawCookie
    }, body: {
      'comment_id': commentid
    });

    if (comment.statusCode == 200) {
      posts.firstWhere((element) => element.id == postid).comments.removeWhere((element) => element.id == commentid);
      filterPosts.firstWhere((element) => element.id == postid).comments.removeWhere((element) => element.id == commentid);
      posts.refresh();
      filterPosts.refresh();
    }
  }

  Future<void> deletePost(String postid, String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final post = await http.delete(Uri.parse('$serverHost/post/delete-post'), headers: {
      'cookie': rawCookie
    }, body: {
      'post_id': postid,
      'image_path':imagePath
    });

    if (post.statusCode == 200) {
      posts.removeWhere((element) => element.id == postid);
      filterPosts.removeWhere((element) => element.id == postid);
      posts.refresh();
      filterPosts.refresh();
    }
  }
}