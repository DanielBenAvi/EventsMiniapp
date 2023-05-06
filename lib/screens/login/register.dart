import 'package:flutter/material.dart';
import 'package:social_hive_client/model/user.dart';
import 'package:social_hive_client/widgets/build_drop_button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _textFieldController_email = TextEditingController();
  final _textFieldController_username = TextEditingController();
  final _textFieldController_avatar = TextEditingController();

  final List<String> roles = const ['ADMIN', 'MINIAPP_USER', 'SUPERAPP_USER'];
  final List<Icon> rolesIcons = const [
    Icon(Icons.admin_panel_settings),
    Icon(Icons.person),
    Icon(Icons.supervisor_account)
  ];

  late String dropdownValue = roles.first;

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
              // buildDropdownButton(),
              DropButton(
                title: "Chooese Role",
                items: roles,
                icons: rolesIcons,
                onDropButtonConfirm: (String value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _continue, child: const Text('Continue')),
            ],
          ),
        ),
      ),
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
