import 'package:flutter/material.dart';
import 'package:social_hive_client/model/singletone_user.dart';
import 'package:social_hive_client/widgets/avatar_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SingletoneUser singletoneUser = SingletoneUser.instance;
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
                photoUrl: singletoneUser.avatar?.toString() ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw4dcOs0ebrWK3g4phCh7cfF-aOM3rhxnsCQ&usqp=CAU',
              ),
              const SizedBox(height: 20),
              Text(
                'Email: ${singletoneUser.email}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'UserName: ${singletoneUser.username}',
              ),
            ],
          )),
        ),
      ),
    );
  }
}
