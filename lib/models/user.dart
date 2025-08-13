class User {
  final String id;
  final String name;
  final String email;
  final String studentId;
  final String university;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.university,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      studentId: json['studentId'],
      university: json['university'],
      avatar: json['avatar'],
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
    };
  }
}
