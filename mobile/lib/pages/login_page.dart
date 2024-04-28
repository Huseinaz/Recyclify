import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 70),
              Image(
                image: AssetImage('assets/image/logo-bg-gray.png'),
                height: 118,
                width: 118,
              ),
              SizedBox(height: 20),
              Text(
                'Log In',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}