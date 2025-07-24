class Video {
  final int id;
  final String title;
  final int category;
  final String categoryName;
  final int language;
  final String languageName;
  final String videoFile;
  final int durationSeconds;
  final int order;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.title,
    required this.category,
    required this.categoryName,
    required this.language,
    required this.languageName,
    required this.videoFile,
    required this.durationSeconds,
    required this.order,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      categoryName: json['category_name'],
      language: json['language'],
      languageName: json['language_name'],
      videoFile: json['video_file'],
      durationSeconds: json['duration_seconds'],
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'category_name': categoryName,
      'language': language,
      'language_name': languageName,
      'video_file': videoFile,
      'duration_seconds': durationSeconds,
      'order': order,
      'created_at': createdAt.toIso8601String(),
    };
  }
}