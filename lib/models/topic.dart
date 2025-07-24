class Topic {
  final int id;
  final String name;
  final String description;
  final String? thumbnail;
  final int totalVideos;
  final int completedVideos;

  Topic({
    required this.id,
    required this.name,
    required this.description,
    this.thumbnail,
    required this.totalVideos,
    required this.completedVideos,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: json['thumbnail'] as String?,
      totalVideos: json['total_videos'],
      completedVideos: json['completed_videos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail ?? '',
      'total_videos': totalVideos,
      'completed_videos': completedVideos,
    };
  }

  Topic copyWith({
    int? id,
    String? name,
    String? description,
    String? thumbnail,
    int? totalVideos,
    int? completedVideos,
  }) {
    return Topic(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      totalVideos: totalVideos ?? this.totalVideos,
      completedVideos: completedVideos ?? this.completedVideos,
    );
  }
}