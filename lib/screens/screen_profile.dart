import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/widgets/avatar_item.dart';

import '../rest_api/command_api.dart';
import '../rest_api/user_api.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final SingletonUser singletonUser = SingletonUser.instance;
  late ObjectBoundary userDetails = ObjectBoundary.empty();

  @override
  void initState() {
    debugPrint('\n -- initState -- ProfileScreen');
    super.initState();
    updateRole();
    _getUserDetails();
  }

  Future updateRole() async {
    await UserApi().updateRole('MINIAPP_USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AvatarItem(
                  photoUrl: singletonUser.avatar!,
                ),
                const SizedBox(height: 20),
                Text('Email: ${singletonUser.email}',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Text('UserName: ${singletonUser.username}'),
                const SizedBox(height: 20),
                Text('Name: ${userDetails.objectDetails['name']}'),
                const SizedBox(height: 20),
                Text('Phone number: ${userDetails.objectDetails['phoneNum']}'),
                const SizedBox(height: 20),
                Text(
                    'Preferences: ${userDetails.objectDetails['preferences']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// todo: get user details from database
  Future<void> _getUserDetails() async {
    await CommandApi().getUserDetails().then((value) {
      setState(() {
        userDetails = value!;
      });
    });
  }
}
