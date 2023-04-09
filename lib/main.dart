import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/app_drawer.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => AppDrawer(),

  },
));

