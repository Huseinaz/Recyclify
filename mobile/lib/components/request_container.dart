import 'package:flutter/material.dart';

class RequestContainer extends StatelessWidget {
  final String name;
  final String address;
  final String accept;
  final String reject;

  const RequestContainer(
      {super.key,
      required this.accept,
      required this.reject,
      required this.name,
      required this.address
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

              Text(
                accept,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  color: Colors.green,
                ),
              ),

              Text(
                reject,
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  color: Colors.red,
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
