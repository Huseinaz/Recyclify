import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder:
            const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E5E5))
            ),
          focusedBorder:
            const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF808080))
            ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w300),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        ),
      ),
    );
  }
}
