import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/my_textfield.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const ChatRoomPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late String userId = '';
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    _initializeUserId();
  }

  void _initializeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getInt(KEY_USER_ID) ?? '').toString();
    });
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
  return StreamBuilder(
    stream: _chatService.getMessages(widget.receiverUserId, userId),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...');
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    },
  );
}

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == userId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(children: [
      Expanded(
        child: MyTextField(
          controller: _messageController,
          hintText: 'Message',
          obscureText: false,
        ),
      ),
      IconButton(
        onPressed: sendMessage,
        icon: const Icon(Icons.arrow_upward, size: 40),
      )
    ]);
  }
}
