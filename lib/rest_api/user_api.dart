import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:social_hive_client/model/singleton_user.dart';

import '../model/boundaries/user_boundary.dart';
import 'base_api.dart';

/// UserApi class
class UserApi extends BaseApi {
  /// create User method
  Future<UserBoundary> postUser(NewUserBoundary newUserBoundary) async {
    // create user
    final response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/users'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(newUserBoundary.toJson()),
    );
    if (response.statusCode == 200) {
      return UserBoundary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  /// update User method
  Future putUser(String email, UserBoundary updateUserBoundary) async {
    final response = await http.put(
      Uri.parse(
          'http://$host:$portNumber/superapp/users/2023b.LiorAriely/$email'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(updateUserBoundary),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }

  /// get User method
  Future<UserBoundary> fetchUser(String userEmail) async {
    final client = RetryClient(http.Client());
    final response = await http.get(Uri.parse(
        'http://$host:$portNumber/superapp/users/login/2023b.LiorAriely/$userEmail'));
    try {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      return UserBoundary.fromJson(userMap);
    } finally {
      client.close();
    }
  }

  Future updateRole(String newRole) async {
    SingletonUser user = SingletonUser.instance;

    Map<String, dynamic> updateUserBoundary = {
      'role': newRole,
    };

    final response = http.put(
      Uri.parse(
          'http://$host:$portNumber/superapp/users/2023b.LiorAriely/${user.email}'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(updateUserBoundary),
    );

    debugPrint('LOG --- response: ${response.toString()}');
  }
}
