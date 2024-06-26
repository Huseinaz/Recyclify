import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String type;
  final int percentage;
  final Color color;

  const MyContainer(
      {super.key,
      required this.type,
      required this.percentage,
      required this.color});

  static Color getColorFromType(String typeName) {
    switch (typeName) {
      case 'Paper':
        return Colors.blue;
      case 'Glass':
        return Colors.green;
      case 'Plastic':
        return const Color(0xFFFFD600);
      case 'Metal':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
