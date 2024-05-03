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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final ChatMessage message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: message.isMe ? Colors.green[200] : Colors.blue[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSendMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}