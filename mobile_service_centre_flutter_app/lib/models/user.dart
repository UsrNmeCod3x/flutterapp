class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? staffRole;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.staffRole,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? json['fullName'] ?? '',
      email: json['email'],
      role: json['role'],
      staffRole: json['staffRole'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'staffRole': staffRole,
    };
  }
}