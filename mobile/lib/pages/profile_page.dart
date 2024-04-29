import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  
                  child: Container(
                    color: const Color(0xFF187B1B),
                    padding: const EdgeInsets.all(16),
                    
                    child: const Column(
                      
                      children: [
                        
                        SizedBox(height: 35),
                        
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/image/logo-bg-gray.png'),
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
              ),

              Expanded(
                flex: 3,
                child: Container(
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}