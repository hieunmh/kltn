class Chat {
  final String id;
  final String userid;
  final String name;
  final String createdAt;
  final String updatedAt;

  Chat({
    required this.id,
    required this.userid,
    required this.name,
    required this.createdAt,
    required this.updatedAt
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      userid: json['user_id'],
      name: json['name'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }

}