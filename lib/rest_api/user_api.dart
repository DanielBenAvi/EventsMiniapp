import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

/// UserApi class
class UserApi {
  /// create User method
  Future<Map<String, dynamic>> postUser(
      String? email, String? username, String? role, String? avatar) async {
    // create user
    final response = await http.post(
      Uri.parse('http://localhost:8084/superapp/users'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "username": username,
        "role": role,
        "avatar": avatar,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {};
  }

  /// update User method
  Map<String, dynamic> putUser(Map<String, dynamic> updateUserBoundary) {
    return updateUserBoundary;
  }

  /// get User method
  Future<Map<String, dynamic>> fetchUser(String userEmail) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8084/superapp/users/login/2023b.LiorAriely/$userEmail'));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      User user = User();
      user = User.fromJson(userMap);
      debugPrint('LOG - user logedin -  $user');
      return userMap;
    }
    return {};
  }
}
