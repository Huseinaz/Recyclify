import 'package:flutter/material.dart';
import 'package:mobile/components/request_container.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 50),
              
              Text(
                'Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 40),

              RequestContainer(
                name: 'John Doe',
                address: 'Beirut, Lebanon',
                accept: 'Accept Request',
                reject: 'Reject Request',
              ),

              SizedBox(height: 20),

              RequestContainer(
                name: 'Jane Doe',
                address: 'Beirut, Lebanon',
                accept: 'Accept Request',
                reject: 'Reject Request',
              ),

            ],
          ),
        ),
      ),
    );
  }
}