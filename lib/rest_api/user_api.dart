import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import '../model/boundaries/user_boundary.dart';

/// UserApi class
class UserApi {
  /// create User method
  Future<UserBoundary> postUser(NewUserBoundary newUserBoundary) async {
    // create user
    final response = await http.post(
      Uri.parse('http://localhost:8084/superapp/users'),
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
  Map<String, dynamic> putUser(Map<String, dynamic> updateUserBoundary) {
    return updateUserBoundary;
  }

  /// get User method
  Future<UserBoundary> fetchUser(String userEmail) async {
    final client = RetryClient(http.Client());
    final response = await http.get(Uri.parse(
        'http://localhost:8084/superapp/users/login/2023b.LiorAriely/$userEmail'));
    try {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      return UserBoundary.fromJson(userMap);
    } finally {
      client.close();
    }
  }
}
