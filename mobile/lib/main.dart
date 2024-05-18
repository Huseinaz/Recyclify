import 'package:flutter/material.dart';
import 'package:mobile/api/firebase_api.dart';
import 'package:mobile/firebase_options.dart';
import 'package:mobile/pages/d_home.dart';
import 'package:mobile/pages/notifications_page.dart';
import 'package:mobile/pages/tracking_page.dart';
import 'package:mobile/pages/u_home.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/signup_page.dart';
import 'package:mobile/pages/get_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile/providers/loader_provider.dart';
import 'package:mobile/services/notification_service.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseApi().initNotifications();
  await NotificationService.instance.initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoaderProvider()),
        // Add other providers here
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
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
        '/notifications': (context) => const NotificationsPage(),
        '/getLocation': (context) => const GetLocation(),
        '/tracking': (context) => const TrackingPage(),
      },
    );
  }
}
