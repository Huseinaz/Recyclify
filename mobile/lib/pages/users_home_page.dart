import 'package:flutter/material.dart';
import 'package:mobile/components/my_button.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: const Column(
            children: [

              SizedBox(height: 50),
              
              Text(
                'Your Container',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 50),

              MyButton(onTap: null, buttonText: 'buttonText')

            ],
          ),
        ),
      ),
    );
  }
}