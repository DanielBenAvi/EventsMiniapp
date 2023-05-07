import 'package:flutter/material.dart';
import 'package:social_hive_client/rest_api/user_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _textFieldEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _textFieldEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        _login();
                      }
                    },
                    child: const Text('Login')),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _screenRegister, child: const Text('Register')),
              ]),
        ),
      ),
    );
  }

  Future<void> _login() async {
    // Map<String, dynamic> respone =
    //     await UserApi().fetchUser(_textFieldEmailController.text);
    // if (respone.isEmpty) {
    // _screenRegister();
    // } else {
    _screenAppDrawer();
    // }
  }

  void _screenRegister() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/register');
  }

  void _screenAppDrawer() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }
}
