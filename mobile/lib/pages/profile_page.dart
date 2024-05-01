import 'package:flutter/material.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/profile_data.dart';

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
                    
                    child: const Column(
                      
                      children: [
                        
                        SizedBox(height: 30),
                        
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage('assets/image/profile.png'),
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

              
              const SizedBox(height: 50),

              Expanded(
                flex: 3,
                child: Column(
                  children: [

                    const SizedBox(height: 20),
                    
                    const ProfileData(
                      label: 'Full Name',
                      data: 'John Doe',
                    ),

                    const SizedBox(height: 20),
                    
                    const ProfileData(
                      label: 'Email',
                      data: 'john.doe@gmail.com',
                    ),

                    const SizedBox(height: 20),
                    
                    const ProfileData(
                      label: 'Password',
                      data: '********',
                    ),

                    const SizedBox(height: 20),
                    
                    const ProfileData(
                      label: 'Address',
                      data: 'Beirut, Lebanon',
                    ),
                    
                    const SizedBox(height: 80),

                    MyButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                    buttonText: 'Save',
                    ),

                  ],
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}