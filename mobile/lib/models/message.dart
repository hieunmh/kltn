class Message {
  final String id;
  final String chatid;
  final String role;
  final String message;
  final String updatedAt;
  final String createdAt;

  Message({
    required this.id, 
    required this.chatid, 
    required this.role, 
    required this.message, 
    required this.updatedAt,
    required this.createdAt
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatid: json['chat_id'],
      role: json['role'],
      message: json['message'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt']
    );
  }
}