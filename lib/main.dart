import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/screen_add_event.dart';
import 'package:social_hive_client/screens/screen_explore_events.dart';
import 'package:social_hive_client/screens/screen_home.dart';
import 'package:social_hive_client/screens/login/screen_login.dart';
import 'package:social_hive_client/screens/login/screen_user_details.dart';
import 'package:social_hive_client/screens/login/screen_register.dart';
import 'package:social_hive_client/screens/screen_my_events.dart';
import 'package:social_hive_client/screens/screen_profile.dart';
import 'package:social_hive_client/widgets/image_picker.dart';

import 'firebase_options.dart';

void main() async {
  // initialize the firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'Social Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const ScreenLogin(),
        '/register': (context) => const ScreenRegister(),
        '/user_details': (context) => const ScreenUserDetails(),
        '/home': (context) => const ScreenHome(),
        '/profile': (context) => const ScreenProfile(),
        '/image_picker': (context) => const ScreenImagePicker(),
        '/add_event': (context) => const ScreenAddEvent(),
        '/my_events': (context) => const ScreenMyEvents(),
        '/explore_events': (context) => const ScreenExploreEvents(),
      },
    ),
  );
}
// initialize the firebase app
