import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
import 'package:mobile/pages/chat_room_page.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);
    final response = await http.get(
      Uri.parse('$HOST/users'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    try {
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(
              jsonDecode(response.body)['users']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Error fetching users: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Messages',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F8),
      body: isLoading
          ? _buildLoader()
          : Container(
              margin: const EdgeInsets.only(top: 40),
              child: _buildUserList(),
            ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    String profileImageUrl = data['profileImageUrl'] ?? '';

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final prefs = snapshot.data!;
          final currentUserEmail = prefs.getString(KEY_USER_EMAIL) ?? '';

          if (currentUserEmail != data['email']) {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
              future: _chatService.getLastMessage(
                  prefs.getInt(KEY_USER_ID).toString(), data['id'].toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : const AssetImage('assets/image/profile1.png')
                                  as ImageProvider,
                        ),
                      ),
                      title: Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: const Text('Loading last message...'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                              receiverUserEmail: data['email'],
                              receiverUserId: data['id'].toString(),
                              receiverUserName: data['name'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      leading: SizedBox(
                        width: 45,
                        height: 45,
                        child: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : const AssetImage('assets/image/profile1.png')
                                  as ImageProvider,
                        ),
                      ),
                      title: Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text('Error: ${snapshot.error}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                              receiverUserEmail: data['email'],
                              receiverUserId: data['id'].toString(),
                              receiverUserName: data['name'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  final lastMessage =
                      snapshot.data != null && snapshot.data!.data() != null
                          ? snapshot.data!.data()!['message'] as String
                          : 'No messages yet';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : const AssetImage('assets/image/profile1.png')
                                  as ImageProvider,
                        ),
                      ),
                      title: Text(
                        data['name'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(lastMessage),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                              receiverUserEmail: data['email'],
                              receiverUserId: data['id'].toString(),
                              receiverUserName: data['name'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
