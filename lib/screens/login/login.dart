import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_hive_client/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:social_hive_client/constans/uri.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
          ]
        ),
      ),
    );
  }

  Future<void> _login() async {
    //  HTTP GET request to server to check if user exists

    await fetchUser(_textFieldController.text);
    //  set user object to current user
  }

  Future fetchUser(String userEmail) async {
    Url url = Url();

    final response = await http.get(Uri.parse((url.getUser()??'') + userEmail));

    if (response.statusCode == 200) {

      Map<String, dynamic> userMap = jsonDecode(response.body);

      if (kDebugMode) {
        print(userMap);
      }

      User user = User(userEmail);
      Navigator.pushNamed(context, '/app_drawer');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Failed'),
        ),
      );
    }
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }
}