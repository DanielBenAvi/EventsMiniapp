import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _textFieldController_email,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: ValidationBuilder().email().maxLength(50).build(),
                ),
                TextFormField(
                    controller: _textFieldController_username,
                    decoration: const InputDecoration(hintText: 'Username'),
                    validator:
                        ValidationBuilder().minLength(3).maxLength(20).build()),
                TextFormField(
                  controller: _textFieldController_avatar,
                  decoration: const InputDecoration(hintText: 'Avatar'),
                  validator: ValidationBuilder().maxLength(50).build(),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _continue();
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
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
