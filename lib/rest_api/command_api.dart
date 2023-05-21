import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/rest_api/user_api.dart';

import 'base_api.dart';

class CommandApi extends BaseApi {
  Future<List<ObjectBoundary>> getMyEvents() async {
    UserApi().updateRole('MINIAPP_USER');

    // Create command
    Map<String, dynamic> command = {
      "commandId": {},
      "command": "GET_MY_EVENTS",
      "targetObject": {
        "objectId": {
          "superapp": "2023b.LiorAriely",
          "internalObjectId": "EMPTY_OBJECT_FOR_COMMAND_THAT_NO_TARGET"
        }
      },
      "invokedBy": {
        "userId": {"superapp": "2023b.LiorAriely", "email": user.email}
      },
      "commandAttributes": {}
    };

    // Post command
    http.Response response = await http.post(
      Uri.parse('http://$host:$portNumber/superapp/miniapp/EVENT'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(command),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load events');
    }

    // get first object from response.body
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> objects = responseBody.values.first;

    // convert to List<ObjectBoundary>
    List<ObjectBoundary> events = [];
    for (Map<String, dynamic> object in objects) {
      events.add(ObjectBoundary.fromJson(object));
    }

    return events;
  }

  /// todo: change base on the preferences
  Future getAllEvent() async {}

  Future getCreatedByMeEvents() async {}

  Future joinEvent() async {}

  Future leaveEvent() async {}
}
