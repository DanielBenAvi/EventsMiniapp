import 'package:flutter/material.dart';

class DatingHome extends StatefulWidget {
  const DatingHome({Key? key}) : super(key: key);

  @override
  State<DatingHome> createState() => _DatingHomeState();
}

class _DatingHomeState extends State<DatingHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Dating'),
    );
  }
}
