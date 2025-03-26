import 'package:mobile/models/user.dart';

class Comment {
  final String id;
  final String postid;
  final String userid;
  final String content;
  final String? imageurl;
  final String createdAt;
  final String updatedAt;
  final User user;

  Comment({
    required this.id,
    required this.postid,
    required this.userid,
    required this.content,
    this.imageurl,
    required this.createdAt,
    required this.updatedAt,
    required this.user
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postid: json['post_id'],
      userid: json['user_id'],
      content: json['content'],
      imageurl: json['image_url'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: User.fromJson(json['user'])
    );
  }
}