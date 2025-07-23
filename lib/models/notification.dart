class Notification {
  final int id;
  final int? video;
  final String? videoTitle;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    this.video,
    this.videoTitle,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],  
      video: json['video'],
      videoTitle: json['video_title'],
      message: json['message'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  
      'video': video,
      'video_title': videoTitle,
      'message': message,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}