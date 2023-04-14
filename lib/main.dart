import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/app_drawer.dart';
import 'package:social_hive_client/screens/login/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => const Login(),
    '/AppDrawer': (context) => const AppDrawer(),

  },
));

