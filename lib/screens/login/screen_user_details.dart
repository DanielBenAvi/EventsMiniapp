import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:social_hive_client/constants/preferences.dart';
import 'package:social_hive_client/constants/sex_preferences.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/boundaries/user_boundary.dart';
import 'package:social_hive_client/model/item_object.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/model/user_details.dart';
import 'package:social_hive_client/rest_api/object_api.dart';
import 'package:social_hive_client/rest_api/user_api.dart';
import 'package:social_hive_client/widgets/multi_select_dialog.dart';

import '../../widgets/build_drop_button.dart';

const List<String> genderList = <String>['Male', 'Female', 'Other'];
const List<Icon> iconList = <Icon>[
  Icon(Icons.male),
  Icon(Icons.female),
  Icon(IconData(0xf888, fontFamily: 'MaterialIcons')),
];

class ScreenUserDetails extends StatefulWidget {
  const ScreenUserDetails({Key? key}) : super(key: key);

  @override
  State<ScreenUserDetails> createState() => _ScreenUserDetailsState();
}

class _ScreenUserDetailsState extends State<ScreenUserDetails> {
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
                  validator: ValidationBuilder()
                      .maxLength(50)
                      .regExp(RegExp('^((?:[1-9][0-9]*)(?:\\.[0-9]+)?)\$'),
                          'Not valid Latitude')
                      .build(),
                ),
                TextFormField(
                  controller: _textFieldControllerLongitude,
                  decoration: const InputDecoration(
                    hintText: 'Longitude',
                  ),
                  validator: ValidationBuilder()
                      .maxLength(50)
                      .regExp(RegExp('^((?:[1-9][0-9]*)(?:\\.[0-9]+)?)\$'),
                          'Not valid Longitude')
                      .build(),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // user
    SingletonUser singletonUser = SingletonUser.instance;
    NewUserBoundary newUserBoundary = NewUserBoundary(
      email: singletonUser.email as String,
      username: singletonUser.username as String,
      role: singletonUser.role as String,
      avatar: singletonUser.avatar as String,
    );
    UserBoundary userBoundary = await UserApi().postUser(newUserBoundary);
    if (userBoundary == null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: User not created'),
        ),
      );
      return;
    }

    // user details
    UserDetails userDetails = UserDetails(
      email: singletonUser.email?.toString() ?? '',
      name: _textFieldControllerName.text,
      phoneNumber: _textFieldControllerPhoneNumber.text,
      interests: _getSetFromList(_selectedPreferences),
      gender: dropdownValue.toString(),
      genderPreferences: _getSetFromList(_selectedSexPreferences),
    );

    debugPrint('userDetails json:${userDetails.toJson()}');
    // Object boundary
    // - location
    final LocationBoundary location = LocationBoundary(
      lat: double.parse(_textFieldControllerLatitude.text),
      lng: double.parse(_textFieldControllerLongitude.text),
    );
    // - userId
    final UserId userId = UserId(
      email: singletonUser.email as String,
      superapp: '2023b.LiorAriely',
    );

    // - createdBy
    final CreatedBy createdBy = CreatedBy(
      userId: userId,
    );

    ObjectBoundary objectBoundary = ObjectBoundary(
      objectId: ObjectId('2023b.LiorAriely', ""),
      type: 'USER_DETAILS',
      alias: 'UserDetails',
      active: true,
      creationTimestamp: DateTime.now(),
      location: location,
      createdBy: createdBy,
      objectDetails: userDetails.toJson(),
    );

    await UserApi().updateRole('SUPERAPP_USER');
    await ObjectApi().postObject(objectBoundary);
    _screenLogin();
  }

  void _screenLogin() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }

  List<String> _getSetFromList(List<ItemObject> list) {
    Set<String> preferences = {};
    for (ItemObject item in list) {
      preferences.add(item.name);
    }
    return preferences.toList();
  }
}
