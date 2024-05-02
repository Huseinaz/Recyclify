import 'package:flutter/material.dart';
import 'package:mobile/pages/d_home.dart';
import 'package:mobile/pages/map_page.dart';
import 'package:mobile/pages/u_home.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/userhome': (context) => const UserPage(),
        '/driverhome': (context) => const DriverPage(),
        '/map': (context) => MapPage(),
      },
    );
  }
}
