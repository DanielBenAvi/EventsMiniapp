import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/base_api.dart';

class ObjectApi extends BaseApi {
  Future<ObjectBoundary> postObject(ObjectBoundary objectBoundary) async {
    debugPrint('\n -- postObject');
    // create user
    final response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'),
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
        'http://$host:$portNumber/superapp/objects/2023b.LiorAriely/$internalObjectId'));
    try {
      Map<String, dynamic> object = jsonDecode(response.body);
      return ObjectBoundary.fromJson(object);
    } finally {
      client.close();
    }
  }

  Future<List<ObjectBoundary>> getAllObjects() async {
    final client = RetryClient(http.Client());
    final response =
        await http.get(Uri.parse('http://$host:$portNumber/superapp/objects'));
    if (response.statusCode == 200) {
      List<dynamic> objects = jsonDecode(response.body);
      List<ObjectBoundary> objectBoundaries = [];
      for (Map<String, dynamic> object in objects) {
        objectBoundaries.add(ObjectBoundary.fromJson(object));
      }
      return objectBoundaries;
    } else {
      throw Exception('Failed to load objects');
    }
  }
}
