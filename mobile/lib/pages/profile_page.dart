import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              
              SizedBox(height: 60),
              
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/image/logo-bg-green.png'),
              ),

              SizedBox(height: 10),

              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}