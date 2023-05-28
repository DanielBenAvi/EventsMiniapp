import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

import '../model/item_object.dart';

class ScreenRegisterUserDetails extends StatefulWidget {
  const ScreenRegisterUserDetails({super.key});

  @override
  State<ScreenRegisterUserDetails> createState() =>
      _ScreenRegisterUserDetailsState();
}

class _ScreenRegisterUserDetailsState extends State<ScreenRegisterUserDetails> {
  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerPhoneNumber = TextEditingController();
  List<ItemObject> _selectedPreferences = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _updateUserRole();
  }

  Future _updateUserRole() async {
    await UserApi().updateRole('SUPERAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _textFieldControllerName,
                    decoration: const InputDecoration(hintText: 'Name'),
                    validator:
                        ValidationBuilder().minLength(3).maxLength(20).build(),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _textFieldControllerPhoneNumber,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                    validator:
                        ValidationBuilder().phone().maxLength(50).build(),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  MultiSelect(
                    "Preferences",
                    "Preferences",
                    Preferences().getPreferences(),
                    onMultiSelectConfirm: (List<ItemObject> results) {
                      _selectedPreferences = results;
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                      onPressed: _register, child: const Text('Register')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPreferences.isEmpty) return;

    try {
      await UserApi().postUserDetails(
        _textFieldControllerName.text,
        _textFieldControllerPhoneNumber.text,
        _selectedPreferences.map((e) => e.name).toList(),
      );
      _screenHome();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _screenHome() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  }
}
