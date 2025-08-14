class User {
  final String id;
  final String name;
  final String email;
  final String studentId;
  final String university;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.university,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      studentId: json['studentId'],
      university: json['university'],
      avatar: json['avatar'],
      createdAt: json['createdAt']?.toDate(),
      updatedAt: json['updatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentId': studentId,
      'university': university,
      'avatar': avatar,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Alias for Firebase compatibility
  Map<String, dynamic> toMap() => toJson();
}
