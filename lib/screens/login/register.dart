import 'package:flutter/material.dart';
import 'package:social_hive_client/model/user.dart';

import '../../constants/sex_preferences.dart';

const List<String> roles = <String>['ADMIN', 'MINIAPP_USER', 'SUPERAPP_USER'];

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _textFieldController_email = TextEditingController();
  final _textFieldController_username = TextEditingController();
  final _textFieldController_avatar = TextEditingController();

  String dropdownValue = roles.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textFieldController_email,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _textFieldController_username,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextField(
                controller: _textFieldController_avatar,
                decoration: const InputDecoration(
                  hintText: 'Avatar',
                ),
              ),
              buildDropdownButton(),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _continue, child: const Text('Continue')),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.man),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: roles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _continue() {
    // save all data to user object
    User user = User();
    user.email = _textFieldController_email.text;
    user.username = _textFieldController_username.text;
    user.role = dropdownValue;
    user.avatar = _textFieldController_avatar.text;
    // log user object
    print(user);
    //  change to next screen
    Navigator.pushNamed(context, '/user_details');
  }
}
