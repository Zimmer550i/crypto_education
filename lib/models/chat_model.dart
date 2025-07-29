class ChatModel {
  String objectId;
  String name;
  String createdAt;
  int user;

  ChatModel({
    required this.objectId,
    required this.name,
    required this.createdAt,
    required this.user,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      objectId: json['object_id'],
      name: json['name'],
      createdAt: json['created_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object_id': objectId,
      'name': name,
      'created_at': createdAt,
      'user': user,
    };
  }
}