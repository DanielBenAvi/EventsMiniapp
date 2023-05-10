class NewUserBoundary {
  // constructor
  String? email;
  String? role;
  String? username;
  String? avatar;

  static final NewUserBoundary _instance = NewUserBoundary._internal();

  // empty constructor
  factory NewUserBoundary() {
    return _instance;
  }

  NewUserBoundary._internal();

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
  NewUserBoundary.fromJson(Map<String, dynamic> json)
      : email = json['userId']['email'],
        role = json['role'],
        username = json['username'],
        avatar = json['avatar'];
}

class UserBoundary {
  UserId userId;
  String role;
  String username;
  String avatar;

  UserBoundary({
    required this.userId,
    required this.role,
    required this.username,
    required this.avatar,
  });

  // fromJson
  UserBoundary.fromJson(Map<String, dynamic> json)
      : userId = UserId.fromJson(json['userId']),
        role = json['role'],
        username = json['username'],
        avatar = json['avatar'];

  // toJson
  Map<String, dynamic> toJson() => {
        'userId': userId.toJson(),
        'role': role,
        'username': username,
        'avatar': avatar,
      };
}

class UserId {
  String superapp;
  String email;

  UserId({required this.superapp, required this.email});

  // fromJson
  UserId.fromJson(Map<String, dynamic> json)
      : superapp = json['superapp'],
        email = json['email'];

  // toJson
  Map<String, dynamic> toJson() => {
        'superapp': superapp,
        'email': email,
      };
}
