import 'package:flutter/material.dart';

class RequestContainer extends StatelessWidget {
  final String name;
  final String address;
  final String leftbutton;
  final String rightbutton;
  final TextStyle? leftButtonStyle;
  final TextStyle? rightButtonStyle;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;

  const RequestContainer(
      {super.key,
      required this.name,
      required this.address,
      required this.leftbutton,
      required this.rightbutton,
      this.leftButtonStyle,
      this.rightButtonStyle,
      this.onLeftButtonPressed,
      this.onRightButtonPressed,
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
                onTap: onLeftButtonPressed,
                child: Text(
                  leftbutton,
                  style: leftButtonStyle,
                ),
              ),

              GestureDetector(
                onTap: onRightButtonPressed,
                child: Text(
                  rightbutton,
                  style: rightButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
