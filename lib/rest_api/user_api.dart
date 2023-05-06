import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/uri.dart';
import '../model/user.dart';

class UserApi {
  String baseUrl = 'http://localhost:8084/superapp/users';

  Map<String, dynamic> postUser(Map<String, dynamic> newUserBoundary) {
    return newUserBoundary;
  }

  Map<String, dynamic> putUser(Map<String, dynamic> updateUserBoundary) {
    return updateUserBoundary;
  }

  Future<Map<String, dynamic>> fetchUser(String userEmail) async {
    Url url = Url();

    final response =
        await http.get(Uri.parse((url.getUser() ?? '') + userEmail));
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      User user = User();
      user = User.fromJson(userMap);
      debugPrint(user.toString());
      return userMap;
    }
    return {};
  }
}
