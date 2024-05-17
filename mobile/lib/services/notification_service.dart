import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('Notification tapped: ${notificationResponse.id}, '
      'action: ${notificationResponse.actionId}, '
      'payload: ${notificationResponse.payload}');
  
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('Notification action tapped with input: ${notificationResponse.input}');
  }
  
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class NotificationService {
  NotificationService._privateConstructor();

  static final NotificationService _instance = NotificationService._privateConstructor();

  static NotificationService get instance => _instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel", 
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future<void> initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetail(),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initLocalNotifications() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    final initializationSettings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final androidPlatform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidPlatform?.createNotificationChannel(_androidChannel);
  }

  NotificationDetails notificationDetail() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: _androidChannel.importance,
        icon: '@mipmap/ic_launcher',
      ),
    );
  }

  Future<void> initNotifications() async {
    final permission = await _firebaseMessaging.requestPermission();
    if (permission.authorizationStatus != AuthorizationStatus.authorized) {
      print('Notification permissions not granted.');
      return;
    }

    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcmToken', fcmToken);
      print('Firebase token: $fcmToken');
    }

    await initPushNotifications();
    await initLocalNotifications();
  }
}
