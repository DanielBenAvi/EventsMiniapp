import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/home.dart';
import 'package:social_hive_client/screens/login/login.dart';
import 'package:social_hive_client/screens/login/register.dart';
import 'package:social_hive_client/screens/login/page_user_details.dart';
import 'package:social_hive_client/screens/profile.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/user_details': (context) => const UserDetailsScreen(),
        '/home': (context) => const Home(),
        '/profile': (context) => const ProfileScreen(),
      },
    ));
