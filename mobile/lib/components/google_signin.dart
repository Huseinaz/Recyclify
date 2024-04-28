import 'package:flutter/material.dart';

class GoogleSignin extends StatelessWidget {
  final Function()? onTap;

  const GoogleSignin({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 27),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/google.png', // Path to your Google icon image asset
              height: 24,
              width: 24,
              // You can adjust the size of the Google icon as needed
            ),
            const SizedBox(width: 10), // Add some spacing between the icon and the text
            const Text(
              "Continue with Google",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
