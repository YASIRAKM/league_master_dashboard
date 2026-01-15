class CaptainModel {
  String username;
  String password;
  String role;

  CaptainModel({
    required this.username,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "role": role,
      };
}
