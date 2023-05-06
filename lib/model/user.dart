class User {
  // constructor
  String? email;
  String? role;
  String? username;
  String? avatar;

  static final User _instance = User._internal();

  // empty constructor
  factory User() {
    return _instance;
  }

  User._internal();

  // getters
  String? get getEmail => email;
  String? get getRole => role;
  String? get getUsername => username;
  String? get getAvatar => avatar;

  // setters
  set setEmail(String? email) => this.email = email;
  set setRole(String? role) => this.role = role;
  set setUsername(String? username) => this.username = username;
  set setAvatar(String? avatar) => this.avatar = avatar;

  // toString
  @override
  String toString() {
    return 'User{email: $email, role: $role, username: $username, avatar: $avatar}';
  }

  // fromJson
  User.fromJson(Map<String, dynamic> json)
      : email = json['userId']['email'],
        role = json['role'],
        username = json['username'],
        avatar = json['avatar'];
}
