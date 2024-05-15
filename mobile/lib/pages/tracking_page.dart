import 'package:flutter/material.dart';
import 'package:mobile/components/tracking_container.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

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
            title: const Text(
              'Tracking Requests',
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

                const SizedBox(height: 40),

                TrackingContainer(
                  name: 'John Doe',
                  status: 'Pending',
                  statusStyle: const TextStyle(
                    color: Colors.green,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}