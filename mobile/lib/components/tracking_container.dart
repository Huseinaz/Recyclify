import 'package:flutter/material.dart';

class TrackingContainer extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const TrackingContainer(
      {super.key,
      required this.name,
      required this.address,
      this.onAccept,
      this.onReject,
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

              GestureDetector(
                onTap: onAccept,
                child: const Text(
                  'Pending',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }
}
