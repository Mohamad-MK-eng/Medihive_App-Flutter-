class User {
  String first_name;
  String last_name;
  String email;
  int? role_id;
  String? profile_picture_url;
  String? _accessToken;
  // for the first time log or register
  User(
      {required this.first_name,
      required this.last_name,
      required this.email,
      this.role_id,
      required this.profile_picture_url,
      required String accessToken})
      : _accessToken = accessToken;
  // هاد لما يكون في المعلومات الأساسة منشان لما بدي جيب الprofile

  String? get accessToken => _accessToken;

  factory User.fromJson(jsonData) {
    final user = jsonData['user'];
    return User(
        first_name: user['first_name'],
        last_name: user['last_name'],
        email: user['email'],
        role_id: user['role_id'],
        profile_picture_url: user['profile_picture'],
        accessToken: jsonData['access_token']);
  }
}
