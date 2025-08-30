class CourseModel {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final DateTime createdAt;

  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
