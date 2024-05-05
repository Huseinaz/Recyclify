import 'package:flutter/material.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_container.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

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
            title: Row(
              children: [
                const Text(
                  'Your Container',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.track_changes),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tracking');
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                const MyContainer(
                  color: Colors.blue,
                  type: 'Paper',
                  percentage: 20,
                ),

                const SizedBox(height: 15),

                const MyContainer(
                  color: Colors.green,
                  type: 'Glass',
                  percentage: 20,
                ),

                const SizedBox(height: 15),

                const MyContainer(
                  color: Colors.yellow,
                  type: 'Plastic',
                  percentage: 20,
                ),

                const SizedBox(height: 15),

                const MyContainer(
                  color: Colors.red,
                  type: 'Metal',
                  percentage: 20,
                ),

                const SizedBox(height: 40),

                MyButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/driverhome');
                  },
                  buttonText: 'Request a driver',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}