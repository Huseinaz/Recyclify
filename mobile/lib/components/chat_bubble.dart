import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({Key? key, required this.message, required this.isSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSender ? Colors.green : Colors.blue, // Set color based on sender
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

class YourClass {
  Widget _buildMessageItem(DocumentSnapshot document, String userId) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Determine alignment and sender based on userId
    bool isSender = data['senderId'] == userId;

    var alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSender) Text(data['senderEmail']), // Show sender email if not sender
            ChatBubble(message: data['message'], isSender: isSender), // Pass isSender to ChatBubble
          ],
        ),
      ),
    );
  }
}
