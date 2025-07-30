class Video {
  final String objectId;
  final String title;
  final int category;
  final String categoryName;
  final int? language;
  final String? languageName;
  final String? videoFile;
  final String? videoFilename;
  final String? videoPath;
  final int? durationSeconds;
  final int order;
  final DateTime createdAt;
  final String subtitleObjectId;
  final DateTime uploadedAt;

  Video({
    required this.objectId,
    required this.title,
    required this.category,
    required this.categoryName,
    this.language,
    this.languageName,
    this.videoFile,
    this.videoFilename,
    this.videoPath,
    required this.durationSeconds,
    required this.order,
    required this.createdAt,
    required this.subtitleObjectId,
    required this.uploadedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      objectId: json['object_id'],
      title: json['title'],
      category: json['category'],
      categoryName: json['category_name'],
      language: json['language'],
      languageName: json['language_name'],
      videoFile: json['video_file'],
      videoFilename: json['video_filename'],
      videoPath: json['video_path'],
      durationSeconds: json['duration_seconds'],
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
      subtitleObjectId: json['subtitle_object_id'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object_id': objectId,
      'title': title,
      'category': category,
      'category_name': categoryName,
      'language': language,
      'language_name': languageName,
      'video_file': videoFile,
      'video_filename': videoFilename,
      'video_path': videoPath,
      'duration_seconds': durationSeconds,
      'order': order,
      'created_at': createdAt.toIso8601String(),
      'subtitle_object_id': subtitleObjectId,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}