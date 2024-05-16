import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/components/notification_card.dart';

class Notification {
  final String message;
  final String time;

  Notification({required this.message, required this.time});

  factory Notification.fromJson(Map<String, dynamic> json) {
    final DateTime createdAt = DateTime.parse(json['created_at']);
    final String formattedTime = DateFormat('HH:mm').format(createdAt);
    return Notification(
      message: json['message'],
      time: formattedTime,
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notification> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    try {
      final response = await http.get(
        Uri.parse('$HOST/notifications'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> notificationData = jsonDecode(response.body);
        setState(() {
          notifications = notificationData.map((data) => Notification.fromJson(data)).toList();
        });
      } else if (response.statusCode == 401) {
        print('Unauthorized: Token may be expired or invalid.');
      } else {
        print('Failed to load notifications with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshNotifications() async {
    await fetchNotifications();
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
        child: isLoading
            ? _buildLoader()
            : RefreshIndicator(
                onRefresh: _refreshNotifications,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        ...List.generate(notifications.length, (index) {
                          return Column(
                            children: [
                              NotificationCard(
                                text: notifications[index].message,
                                time: notifications[index].time,
                              ),
                              if (index < notifications.length - 1)
                                const SizedBox(height: 10),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }
}
