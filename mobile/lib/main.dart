import 'package:flutter/material.dart';
import 'package:mobile/pages/drivers_home_page.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/notification_page.dart';
import 'package:mobile/pages/profile_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/users_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/userhome': (context) => const UserHomePage(),
        '/driverhome': (context) => const DriverHomePage(),
        '/profile': (context) => const ProfilePage(),
        '/notification': (context) => NotificationPage(),
      },
    );
  }
}
