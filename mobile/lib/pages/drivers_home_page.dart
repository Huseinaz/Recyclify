import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/request_container.dart';

class DriverHomePage extends StatelessWidget {
  DriverHomePage({super.key});

  final TextEditingController _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 50),
                
                const Text(
                  'Requests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 40),
                
                CupertinoSearchTextField(
                  controller: _textController,
                ),
                
                const SizedBox(height: 20),

                RequestContainer(
                  name: 'John Doe',
                  address: 'Beirut, Lebanon',
                  onAccept: () {
                    print('Accept request');
                  },
                  onReject: () {
                    print('Reject request');
                  },
                ),

                const SizedBox(height: 20),

                RequestContainer(
                  name: 'Jane Doe',
                  address: 'Beirut, Lebanon',
                  onAccept: () {
                    print('Accept request');
                  },
                  onReject: () {
                    print('Reject request');
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}