import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const MyButton({Key? key, required this.onTap, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 27),
        decoration: BoxDecoration(
          color: const Color(0xFF187B1B),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          // Remove 'const' from here
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
