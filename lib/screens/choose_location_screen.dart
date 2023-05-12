import 'package:flutter/material.dart';
import 'package:social_hive_client/constants/Constants.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key});

  @override
  ChooseLocationScreenState createState() => ChooseLocationScreenState();
}

class ChooseLocationScreenState extends State<ChooseLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Choose Location Screen')
      ),
    );
  }
}
