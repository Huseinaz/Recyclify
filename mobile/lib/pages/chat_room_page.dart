import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.isMe,
  });
}

class ChatRoomPage extends StatefulWidget {
  final Image profile;
  final String name;

  const ChatRoomPage({
    super.key,
    required this.profile,
    required this.name,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<ChatMessage> _messages = [];

  final TextEditingController _textController = TextEditingController();

  void _handleSendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: text, isMe: true));
        _messages.add(ChatMessage(text: 'This is a reply', isMe: false));
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.profile.image,
            ),
            const SizedBox(width: 10),
            Text(widget.name),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F8),
    );
  }
}