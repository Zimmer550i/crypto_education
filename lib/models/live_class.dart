class LiveClass {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final int durationMinutes;
  final String link;
  final DateTime createdAt;

  LiveClass({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.durationMinutes,
    required this.link,
    required this.createdAt,
  });

  factory LiveClass.fromJson(Map<String, dynamic> json) {
    return LiveClass(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['date_time']),
      durationMinutes: json['duration_minutes'],
      link: json['link'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_time': dateTime.toIso8601String(),
      'duration_minutes': durationMinutes,
      'link': link,
      'created_at': createdAt.toIso8601String(),
    };
  }
}