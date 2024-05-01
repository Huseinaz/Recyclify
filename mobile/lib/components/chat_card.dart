import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final Image profile;
  final String name;
  final String lastMessage;
  final String time;

  const ChatCard({
    super.key,
    required this.profile,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: profile.image,
          radius: 25,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                lastMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            height: 2,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
