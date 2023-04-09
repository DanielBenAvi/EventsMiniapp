import 'package:flutter/material.dart';

class GroupsHome extends StatefulWidget {
  const GroupsHome({Key? key}) : super(key: key);

  @override
  State<GroupsHome> createState() => _GroupsHomeState();
}

class _GroupsHomeState extends State<GroupsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Groups'),
    );
  }
}
