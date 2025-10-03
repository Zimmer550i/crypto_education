class User {
  final int userId;
  final String fullName;
  final String email;
  final String? image; 
  final String role;
  final String language;
  String subscription;
  final String? googleId;
  final Map<String, dynamic> videosProgress;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;
  final String? otp;
  final DateTime? otpExpired;
  final DateTime dateJoined;
  final DateTime lastLogin;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    this.image, 
    required this.role,
    required this.language,
    required this.subscription,
    this.googleId,
    required this.videosProgress,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    this.otp,
    this.otpExpired,
    required this.dateJoined,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      fullName: json['full_name'],
      email: json['email'],
      image: json['image'], 
      role: json['role'],
      language: json['language'],
      subscription: json['subscription'],
      googleId: json['google_id'],
      videosProgress: Map<String, dynamic>.from(json['videos_progress'] ?? {}),
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      otp: json['otp'],
      otpExpired: json['otp_expired'] != null ? DateTime.parse(json['otp_expired']) : null,
      dateJoined: DateTime.parse(json['date_joined']),
      lastLogin: DateTime.parse(json['last_login']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'image': image, 
      'role': role,
      'language': language,
      'subscription': subscription,
      'google_id': googleId,
      'videos_progress': videosProgress,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'otp': otp,
      'otp_expired': otpExpired?.toIso8601String(),
      'date_joined': dateJoined.toIso8601String(),
      'last_login': lastLogin.toIso8601String(),
    };
  }
}