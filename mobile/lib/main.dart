import 'package:flutter/material.dart';
import 'package:mobile/api/firebase_api.dart';
import 'package:mobile/firebase_options.dart';
import 'package:mobile/pages/d_home.dart';
import 'package:mobile/pages/map_page.dart';
import 'package:mobile/pages/notifications_page.dart';
import 'package:mobile/pages/u_home.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/userhome': (context) => const UserPage(),
        '/driverhome': (context) => const DriverPage(),
        '/map': (context) => MapPage(),
        '/notifications': (context) => const NotificationsPage(),
      },
    );
  }
}
