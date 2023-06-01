import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_demo_object.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/base_api.dart';
import 'package:social_hive_client/rest_api/user_api.dart';

class ObjectApi extends BaseApi {
  Future<ObjectBoundary> postObject(ObjectBoundary objectBoundary) async {
    await UserApi().updateRole(
        'SUPERAPP_USER'); // update role to SUPERAPP_USER only SuperApp_user can create objects
    debugPrint('\n -- postObject');
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

  Future postObjectJson(Map<String, dynamic> objectBoundary) async {
    debugPrint('LOG --- POST Event');
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'
          '?userSuperapp=$superApp&userEmail=${SingletonUser.instance.email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(objectBoundary),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to create event');
      throw Exception(response.body);
    } else {
      debugPrint('LOG --- Success to create event');
    }
  }

  Future getDemoObject() async {
    final client = RetryClient(http.Client());
    try {
      final response = await client.get(Uri.parse(
          'http://$host:$portNumber/superapp/objects/search/byAlias/OBJECT_FOR_COMMAND_WITHOUT_TARGET_OBJECT?userSuperapp=$superApp&userEmail=${SingletonUser.instance.email}'));
      if (response.statusCode != 200) {
        debugPrint('LOG --- Failed to get demo object');
        return;
      }

      if (jsonDecode(response.body).isEmpty) {
        debugPrint('LOG --- Demo object not found, creating one');
        await UserApi().updateRole(
            'SUPERAPP_USER'); // update role to SUPERAPP_USER only SuperApp_user can create objects
        // await createDemoObject();
        return;
      }

      Map<String, dynamic> object = jsonDecode(response.body).first;
      SingletonDemoObject singletonDemoObject = SingletonDemoObject.instance;
      singletonDemoObject.uuid = object['objectId']['internalObjectId'];
      debugPrint('LOG --- ${SingletonDemoObject.instance}');
    } catch (e) {
      debugPrint('LOG --- Failed to get demo object');
    } finally {
      client.close();
    }
  }

  Future createDemoObject() async {
    Map<String, dynamic> map = {
      "objectId": {},
      "type": "DEFAULT",
      "alias": "OBJECT_FOR_COMMAND_WITHOUT_TARGET_OBJECT",
      "active": true,
      "location": {"lat": 10.200, "lng": 10.200},
      "createdBy": {
        "userId": {
          "superapp": "2023b.LiorAriely",
          "email": "ben.avi.daniel@s.afeka.ac.il"
        }
      },
      "objectDetails": {}
    };
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/objects'
          '?userSuperapp=$superApp&userEmail=${user.email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode != 200) {
      debugPrint('LOG --- Failed to create demo object');
      throw Exception(response.body);
    } else {
      debugPrint('LOG --- Success to create demo object');
    }
  }
}
