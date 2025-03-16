import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;

  final serverHost = Env.serverhost;


  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  Future<void> getPostList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawCookie = prefs.getString('cookie') ?? '';

    final postlist = await http.get(Uri.parse('$serverHost/get-post-by-condition?subject=math'), headers: {
      'cookie': rawCookie
    });
    if (postlist.statusCode == 200) {
      final data = json.decode(postlist.body)['posts'] as List;
      posts.value = data.map((p) => Post.fromJson(p as Map<String, dynamic>)).toList();
    }
  }
}