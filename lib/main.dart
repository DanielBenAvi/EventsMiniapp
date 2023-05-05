import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/app_drawer.dart';
import 'package:social_hive_client/screens/login/login.dart';
import 'package:social_hive_client/screens/login/register.dart';
import 'package:social_hive_client/screens/login/page_user_details.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/user_details': (context) => const UserDetails(),
        '/app_drawer': (context) => const AppDrawer(),
      },
    ));
