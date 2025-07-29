class MessageModel {
  String objectId;
  String role;
  String content;
  String timestamp;
  String sessionId;

  MessageModel({
    required this.objectId,
    required this.role,
    required this.content,
    required this.timestamp,
    required this.sessionId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      objectId: json['object_id'],
      role: json['role'],
      content: json['content'],
      timestamp: json['timestamp'],
      sessionId: json['session_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object_id': objectId,
      'role': role,
      'content': content,
      'timestamp': timestamp,
      'session_id': sessionId,
    };
  }
}