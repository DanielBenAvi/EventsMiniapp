import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ObjectApi {
  Future<ObjectBoundary> postObject(ObjectBoundary objectBoundary) async {
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
      return ObjectBoundary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Object.');
    }
  }
}
