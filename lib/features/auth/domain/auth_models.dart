class AuthResponse {
  final String token;
  final User user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class User {
  final int id;
  final String role;
  final int? teamId;
  final String username;

  User({
    required this.id,
    required this.role,
    this.teamId,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      role: json['role'] as String,
      teamId: json['team_id'] as int?,
      username: json['username'] as String,
    );
  }
}
