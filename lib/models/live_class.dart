class LiveClass {
  final int id;
  final String title;
  final String description;
  final DateTime? dateTime; // Nullable
  final int durationMinutes;
  final String link;
  final DateTime? createdAt; // Nullable

  LiveClass({
    required this.id,
    required this.title,
    required this.description,
    this.dateTime,
    required this.durationMinutes,
    required this.link,
    this.createdAt,
  });

  factory LiveClass.fromJson(Map<String, dynamic> json) {
    return LiveClass(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: json['date_time'] != null
          ? DateTime.tryParse(json['date_time'])
          : null, // Safe parsing
      durationMinutes: json['duration_minutes'],
      link: json['link'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null, // Safe parsing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_time': dateTime?.toIso8601String(),
      'duration_minutes': durationMinutes,
      'link': link,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
