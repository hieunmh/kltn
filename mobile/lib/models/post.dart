import 'package:mobile/models/comment.dart';
import 'package:mobile/models/user.dart';

class Post {
  final String id;
  final String userid;
  final String subject;
  final String content;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;  
  final User user;
  final List<Comment> comments;


  Post({
    required this.id,
    required this.userid,
    required this.subject,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.comments
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userid: json['user_id'],
      subject: json['subject'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List).map((comment) => Comment.fromJson(comment)).toList()
    );
  }
}