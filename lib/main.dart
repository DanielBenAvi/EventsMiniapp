import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_hive_client/screens/add_event.dart';
import 'package:social_hive_client/screens/home.dart';
import 'package:social_hive_client/screens/login/login.dart';
import 'package:social_hive_client/screens/login/page_user_details.dart';
import 'package:social_hive_client/screens/login/register.dart';
import 'package:social_hive_client/screens/my_events.dart';
import 'package:social_hive_client/screens/profile.dart';
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
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/user_details': (context) => const UserDetailsScreen(),
        '/home': (context) => const Home(),
        '/profile': (context) => const ProfileScreen(),
        '/image_picker': (context) => const ImagePickerScreen(),
        '/add_event': (context) => const AddEventScreen(),
        '/my_events': (context) => const MyEventsScreen(),
      },
    ),
  );
}
// initialize the firebase app
