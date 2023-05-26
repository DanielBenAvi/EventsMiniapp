import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/model/boundaries/user_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/user_api.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _textFieldEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text("Events", style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 40),
              TextFormField(
                controller: _textFieldEmailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: ValidationBuilder().email().maxLength(50).build(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: const Text('Login')),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _screenRegister,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    UserBoundary userBoundary =
        await UserApi().getUser(_textFieldEmailController.text);

    SingletonUser singletonUser = SingletonUser.instance;
    singletonUser.email = userBoundary.userId.email;
    singletonUser.username = userBoundary.username;
    singletonUser.avatar = userBoundary.avatar;
    singletonUser.role = userBoundary.role;

    _screenHome();
  }

  void _screenRegister() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/register');
  }

  void _screenHome() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }
}
