import 'package:flutter/material.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/constants/sex_preferences.dart';
import 'package:social_hive_client/model/item_object.dart';
import 'package:social_hive_client/model/user.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';
import 'package:social_hive_client/widgets/snack_bar.dart';
import '../../widgets/build_drop_button.dart';

const List<String> genderList = <String>['Male', 'Female', 'Other'];
const List<Icon> iconList = <Icon>[
  Icon(Icons.male),
  Icon(Icons.female),
  Icon(IconData(0xf888, fontFamily: 'MaterialIcons')),
];

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
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
              DropButton(
                title: 'Gender',
                items: genderList,
                icons: iconList,
                onDropButtonConfirm: (String value) {
                  dropdownValue = value;
                  debugPrint(dropdownValue);
                },
              ),
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

  Future<void> _continue() async {
    const Snack(title: "Creating User");
    // user
    User user = User();
    await UserApi().postUser(
      user.getEmail,
      user.getUsername,
      user.getRole,
      user.getAvatar,
    );
    // user details
    final String name = _textFieldControllerName.text;
    final String phoneNumber = _textFieldControllerPhoneNumber.text;
    final String latitude = _textFieldControllerLatitude.text;
    final String longitude = _textFieldControllerLongitude.text;
    final List<ItemObject> preferences = _selectedPreferences;
    final String gender = dropdownValue.toString();
    final List<ItemObject> sexPreferences = _selectedSexPreferences;
    _screenLogin();
  }

  void _screenLogin() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }
}
