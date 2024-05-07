import 'package:flutter/material.dart';
import 'package:mobile/components/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 40),

                NotificationCard(
                  text: 'Your Metal Container will be full soon.',
                  time: '12:00',
                ),

                SizedBox(height: 20),

                NotificationCard(
                  text: 'Your Metal Container will be full soon.',
                  time: '12:00',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}