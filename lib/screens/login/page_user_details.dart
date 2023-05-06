import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/constants/sex_preferences.dart';
import 'package:social_hive_client/model/item_object.dart';
import 'package:social_hive_client/model/user.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

const List<String> genderList = <String>['Male', 'Female', 'Other'];
const List<Icon> iconList = <Icon>[
  Icon(Icons.male),
  Icon(Icons.female),
  Icon(IconData(0xf888, fontFamily: 'MaterialIcons')),
];

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerPhoneNumber = TextEditingController();
  final _textFieldControllerLatitude = TextEditingController();
  final _textFieldControllerLongitude = TextEditingController();

  List<ItemObject> _selectedPreferences = [];
  List<ItemObject> _selectedSexPreferences = [];

  String dropdownValue = genderList.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _textFieldControllerName,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: _textFieldControllerPhoneNumber,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 40),
              MultiSelect(
                "Preferences",
                "Preferences",
                Preferences().getPreferences(),
                onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedPreferences = results;
                },
              ),
              const SizedBox(height: 20),
              buildDropdownButton(),
              const SizedBox(height: 20),
              MultiSelect(
                "Sex Preferences",
                "Sex Preferences",
                SexPreferences().getPreferences(),
                onMultiSelectConfirm: (List<ItemObject> results) {
                  _selectedSexPreferences = results;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textFieldControllerLatitude,
                decoration: const InputDecoration(
                  hintText: 'Latitude',
                ),
              ),
              TextField(
                controller: _textFieldControllerLongitude,
                decoration: const InputDecoration(
                  hintText: 'Longitude',
                ),
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

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: dropdownValue == genderList[0]
          ? iconList[0]
          : dropdownValue == genderList[1]
              ? iconList[1]
              : iconList[2],
      iconEnabledColor: Colors.blue,
      iconDisabledColor: Colors.blue,
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: genderList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Future<void> _continue() async {
    // user
    User user = User.empty();
    // await createUser(user);
    // user details
    final String name = _textFieldControllerName.text;
    final String phoneNumber = _textFieldControllerPhoneNumber.text;
    final String latitude = _textFieldControllerLatitude.text;
    final String longitude = _textFieldControllerLongitude.text;
    final List<ItemObject> preferences = _selectedPreferences;
    final String gender = dropdownValue.toString();
    final List<ItemObject> sexPreferences = _selectedSexPreferences;

    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
    // close current screen
  }

  Future<void> createUser(User user) async {
    // circular progress indicator
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // create user
    final response = await http.post(
      Uri.parse('http://localhost:8084/superapp/users'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode(<String, dynamic>{
        "email": user.getEmail!,
        "username": user.getUsername!,
        "role": user.getRole!,
        "avatar": user.getAvatar!,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User created')),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating user')),
      );
    }
  }
}
