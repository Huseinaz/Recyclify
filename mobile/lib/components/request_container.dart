import 'package:flutter/material.dart';

class RequestContainer extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const RequestContainer(
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
          
          Text(
            name,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),

          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: onAccept,
                child: const Text(
                  'Accept Request',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              GestureDetector(
                onTap: onReject,
                child: const Text(
                  'Reject Request',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
