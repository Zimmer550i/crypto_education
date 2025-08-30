class Topic {
  final int id;
  final int course;
  final String name;
  final String description;
  final String? thumbnail;
  final int totalVideos;
  final int completedVideos;
  final List<dynamic> videos;

  Topic({
    required this.id,
    required this.course,
    required this.name,
    required this.description,
    this.thumbnail,
    required this.totalVideos,
    required this.completedVideos,
    required this.videos,
  });

  factory Topic.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Topic(
        id: 0,
        course: 0,
        name: "",
        description: "",
        thumbnail: null,
        totalVideos: 0,
        completedVideos: 0,
        videos: [],
      );
    }

    return Topic(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? "0") ?? 0,
      course: json['course'] is int ? json['course'] : int.tryParse(json['course']?.toString() ?? "0") ?? 0,
      name: json['name']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
      thumbnail: json['thumbnail']?.toString(),
      totalVideos: json['total_videos'] is int
          ? json['total_videos']
          : int.tryParse(json['total_videos']?.toString() ?? "0") ?? 0,
      completedVideos: json['completed_videos'] is int
          ? json['completed_videos']
          : int.tryParse(json['completed_videos']?.toString() ?? "0") ?? 0,
      videos: json['videos'] != null
          ? List<dynamic>.from(json['videos'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course': course,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'total_videos': totalVideos,
      'completed_videos': completedVideos,
      'videos': videos,
    };
  }

  Topic copyWith({
    int? id,
    int? course,
    String? name,
    String? description,
    String? thumbnail,
    int? totalVideos,
    int? completedVideos,
    List<dynamic>? videos,
  }) {
    return Topic(
      id: id ?? this.id,
      course: course ?? this.course,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      totalVideos: totalVideos ?? this.totalVideos,
      completedVideos: completedVideos ?? this.completedVideos,
      videos: videos ?? this.videos,
    );
  }
}
