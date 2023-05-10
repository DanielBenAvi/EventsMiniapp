class SingletoneUser {
  String? email;
  String? username;
  String? role;
  String? avatar;

  static SingletoneUser? _instance;

  SingletoneUser._internal();

  static SingletoneUser get instance {
    _instance ??= SingletoneUser._internal();
    return _instance!;
  }

  @override
  String toString() {
    return 'SingletoneUser{email: $email, username: $username, role: $role, avatar: $avatar}';
  }
}
