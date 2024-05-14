import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/components/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.get(
      Uri.parse('$HOST/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        notifications = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      print('Failed to load notifications');
    }
  }

 @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                ...notifications.map((notification) => NotificationCard(
                  text: notification['message'],
                  time: notification['created_at'],
                )).toList(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}