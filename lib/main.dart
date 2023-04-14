import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/app_drawer.dart';
import 'package:social_hive_client/screens/login/login.dart';
import 'package:social_hive_client/screens/login/register.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => const Login(),
    '/register': (context) => const Register(),
    '/app_drawer': (context) => const AppDrawer(),

  },
));

