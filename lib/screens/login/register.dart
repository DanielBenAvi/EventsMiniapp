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
  final _textFieldControllerEmail = TextEditingController();
  final _textFieldControllerUsername = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _avatarPath =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw4dcOs0ebrWK3g4phCh7cfF-aOM3rhxnsCQ&usqp=CAU';

  final List<String> roles = const ['MINIAPP_USER', 'ADMIN', 'SUPERAPP_USER'];
  final List<Icon> rolesIcons = const [
    Icon(Icons.person),
    Icon(Icons.admin_panel_settings),
    Icon(Icons.supervisor_account)
  ];

  late String dropdownValue = roles.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            _avatarPath,
                          ),
                          fit: BoxFit.contain),
                    ),
                  ),
                  TextFormField(
                    controller: _textFieldControllerEmail,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator:
                        ValidationBuilder().email().maxLength(50).build(),
                  ),
                  TextFormField(
                      controller: _textFieldControllerUsername,
                      decoration: const InputDecoration(hintText: 'Username'),
                      validator: ValidationBuilder()
                          .minLength(3)
                          .maxLength(20)
                          .build()),
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
                        _imagePicker(context);
                      },
                      child: const Text('Choose Avatar')),
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
      ),
    );
  }

  void _continue() {
    // save all data to user object
    User user = User();
    user.email = _textFieldControllerEmail.text;
    user.username = _textFieldControllerUsername.text;
    user.role = dropdownValue;
    user.avatar = _avatarPath;
    // log user object
    debugPrint(user.toString());
    //  change to next screen
    Navigator.pushNamed(context, '/user_details');
  }

  Future<void> _imagePicker(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/image_picker');
    setState(() {
      _avatarPath = (result as String?)!;
    });
    if (!mounted) return;
  }
}
