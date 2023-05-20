import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart';
import 'package:social_hive_client/model/boundaries/command_boundary.dart';
import 'package:social_hive_client/rest_api/user_api.dart';

import 'base_api.dart';

class CommandApi extends BaseApi {
  Future<List<Event>> getAllEvents(CommandBoundary commandBoundary) async {
    UserApi().updateRole('MINIAPP_USER');
    final response = await post(
        Uri.parse('http://$host:$portNumber/superapp/commands'),
        body: jsonEncode(commandBoundary.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get all events.');
    }
  }
}
