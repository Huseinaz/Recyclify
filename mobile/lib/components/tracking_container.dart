import 'package:flutter/material.dart';

class TrackingContainer extends StatelessWidget {
  final String name;
  final String status;
  final TextStyle? statusStyle;

  const TrackingContainer({
    super.key,
    required this.name,
    required this.status,
    this.statusStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                status,
                style: statusStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
