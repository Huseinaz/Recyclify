import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/consts.dart';

class ChatService extends ChangeNotifier {
  // late final String token;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> initialize() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString(KEY_ACCESS_TOKEN) ?? '';
  // }

  Future<void> sendMessage(String receiverId, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentUserId = (prefs.getInt(KEY_USER_ID) ?? '').toString();
    final currentUserEmail = prefs.getString(KEY_USER_EMAIL) ?? '';
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      receiverId: receiverId,
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
