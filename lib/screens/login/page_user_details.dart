import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/constants/sex_preferences.dart';
import 'package:social_hive_client/model/item_object.dart';
import 'package:social_hive_client/model/user.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _textFieldControllerName,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator:
                      ValidationBuilder().minLength(3).maxLength(20).build(),
                ),
                TextFormField(
                  controller: _textFieldControllerPhoneNumber,
                  decoration: const InputDecoration(hintText: 'Phone Number'),
                  validator: ValidationBuilder().phone().maxLength(50).build(),
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
                TextFormField(
                  controller: _textFieldControllerLatitude,
                  decoration: const InputDecoration(
                    hintText: 'Latitude',
                  ),
                  validator: ValidationBuilder().maxLength(50).build(),
                ),
                TextFormField(
                  controller: _textFieldControllerLongitude,
                  decoration: const InputDecoration(
                    hintText: 'Longitude',
                  ),
                  validator: ValidationBuilder().maxLength(50).build(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _continue();
                      }
                    },
                    child: const Text('Continue')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _continue() async {
    // const Snack(title: "Creating User");
    // cirucluar progress indicator
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // user
    User user = User();
    // await UserApi().postUser(
    //   user.getEmail,
    //   user.getUsername,
    //   user.getRole,
    //   user.getAvatar,
    // );
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
