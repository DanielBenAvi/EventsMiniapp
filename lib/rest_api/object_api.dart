import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';

class ObjectApi {
  Future<ObjectBoundary> postObject(ObjectBoundary objectBoundary) async {
    debugPrint('\n -- postObject');
    // create user
    final response = await http.post(
      Uri.parse('http://localhost:8084/superapp/objects'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(objectBoundary.toJson()),
    );
    if (response.statusCode == 200) {
      ObjectBoundary objectBoundary =
          ObjectBoundary.fromJson(jsonDecode(response.body));
      SingletonUser singletonUser = SingletonUser.instance;
      singletonUser.details = objectBoundary.objectId.internalObjectId;
      debugPrint('objectBoundary: ${objectBoundary.toJson()}');
      return objectBoundary;
    } else {
      throw Exception('Failed to create Object.');
    }
  }

  Future<ObjectBoundary> getObjectBoundary(String internalObjectId) async {
    final client = RetryClient(http.Client());
    final response = await http.get(Uri.parse(
        'http://localhost:8084/superapp/objects/2023b.LiorAriely/$internalObjectId'));
    try {
      Map<String, dynamic> object = jsonDecode(response.body);
      return ObjectBoundary.fromJson(object);
    } finally {
      client.close();
    }
  }
}
