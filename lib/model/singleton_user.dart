import 'package:social_hive_client/model/boundaries/object_boundary.dart';

import 'boundaries/user_boundary.dart';

class SingletonUser {
  String? email;
  String? username;
  String? role;
  String? avatar;
  String? details;

  static SingletonUser? _instance;

  SingletonUser._internal();

  static SingletonUser get instance {
    _instance ??= SingletonUser._internal();
    return _instance!;
  }

  @override
  String toString() {
    return 'SingletonUser{email: $email, username: $username, role: $role, avatar: $avatar, details: $details}';
  }

  ObjectId get objectId => ObjectId('2023b.LiorAriely', email as String);

  CreatedBy get createdBy => CreatedBy(
        userId: UserId(
          email: email.toString(),
          superapp: '2023b.LiorAriely',
        ),
      );
}
