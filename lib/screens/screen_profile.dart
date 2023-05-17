import 'package:flutter/material.dart';
import 'package:social_hive_client/model/boundaries/object_boundary.dart';
import 'package:social_hive_client/model/singleton_user.dart';
import 'package:social_hive_client/rest_api/object_api.dart';
import 'package:social_hive_client/widgets/avatar_item.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final SingletonUser singletonUser = SingletonUser.instance;
  late ObjectBoundary objectBoundary;
  String lateName = '';
  String latePhone = '';

  @override
  void initState() {
    debugPrint('\n -- initState -- ProfileScreen');
    super.initState();
    _getUserDetails();
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
                photoUrl: singletonUser.avatar?.toString() ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw4dcOs0ebrWK3g4phCh7cfF-aOM3rhxnsCQ&usqp=CAU',
              ),
              const SizedBox(height: 20),
              Text(
                'Email: ${singletonUser.email}',
                style: const TextStyle(
                  fontSize: 20,
                  // color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'UserName: ${singletonUser.username}',
              ),
              const SizedBox(height: 20),
              Text(
                'Name: $lateName',
              ),
              const SizedBox(height: 20),
              Text(
                'Phone: $latePhone',
              ),
              const SizedBox(height: 20),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _getUserDetails() async {
    objectBoundary =
        await ObjectApi().getObjectBoundary(singletonUser.details.toString());
    debugPrint('objectBoundary: $objectBoundary');
    setState(() {
      lateName = objectBoundary.objectDetails['name'];
      latePhone = objectBoundary.objectDetails['phoneNumber'];
    });
  }
}
