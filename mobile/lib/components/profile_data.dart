import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  final String label;
  final String data;

  const ProfileData({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, left: 25),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          Text(
            data,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }
}
