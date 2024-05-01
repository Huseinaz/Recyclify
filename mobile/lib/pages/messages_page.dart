import 'package:flutter/material.dart';
import 'package:mobile/components/chat_card.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Messages',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 40),
              
              ChatCard(
                profile: Image.asset('assets/image/profile.png'),
                name: 'John Doe',
                lastMessage:'This is a message This is a message This is a message',
                time: '12:00',
              ),
              
              const SizedBox(height: 20),
              
              ChatCard(
                profile: Image.asset('assets/image/profile.png'),
                name: 'John Doe',
                lastMessage: 'This is a message',
                time: '12:00',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
