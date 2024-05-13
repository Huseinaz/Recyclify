import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/request_container.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
import 'package:mobile/pages/chat_room_page.dart';
import 'package:mobile/pages/map_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final TextEditingController _textController = TextEditingController(text: '');
  List<Map<String, dynamic>> driverRequests = [];

  @override
  void initState() {
    super.initState();
    fetchDriverRequests();
  }

  Future<void> fetchDriverRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.get(
      Uri.parse('$HOST/viewRequests'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        driverRequests = List<Map<String, dynamic>>.from(jsonDecode(response.body)['driver_request']);
      });
    } else {
      print('Failed to load driver requests data');
    }
  }

  Future<void> handleRequest(int id, bool accept, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.post(
      Uri.parse('$HOST/driverRequest/$id/${accept ? 'accept' : 'reject'}Request'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        driverRequests[index]['showNewButtons'] = accept;
      });
      print('${accept ? 'Request accepted' : 'Request rejected'}');
    } else {
      print('Failed to ${accept ? 'accept' : 'reject'} request: ${response.body}');
    }
  }

  void navigateToChatRoom(dynamic receiverEmail, dynamic receiverId) {
  String email = receiverEmail.toString();
  String id = receiverId.toString();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatRoomPage(
        receiverUserEmail: email,
        receiverUserId: id,
      ),
    ),
  );
}

  void navigateToMapPage(double latitude, double longitude) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MapPage(destinationLatitude: latitude, destinationLongitude: longitude),
    ),
  );
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
              'Requests',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),
                
                CupertinoSearchTextField(
                  controller: _textController,
                ),
                
                const SizedBox(height: 20),

                for (var i = 0; i < driverRequests.length; i++)
                Column(
                  children: [
                    if (driverRequests[i]['showNewButtons'] ?? false)
                      RequestContainer(
                        name: driverRequests[i]['user']['first_name'] +
                            ' ' +
                            driverRequests[i]['user']['last_name'],
                        address: 'Beirut, Lebanon',
                        leftbutton: 'Chat',
                        rightbutton: 'Get direction',
                        onLeftButtonPressed: () {
                          navigateToChatRoom(
                            driverRequests[i]['user']['email'],
                            driverRequests[i]['user']['id'],
                          );
                        },
                        leftButtonStyle: const TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        onRightButtonPressed: () {
                          navigateToMapPage(
                            driverRequests[i]['user']['latitude'],
                            driverRequests[i]['user']['longitude'],
                          );
                        },
                        rightButtonStyle: const TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (!(driverRequests[i]['showNewButtons'] ?? false))
                      RequestContainer(
                        name: driverRequests[i]['user']['first_name'] +
                            ' ' +
                            driverRequests[i]['user']['last_name'],
                        address: 'Beirut, Lebanon',
                        leftbutton: 'Accept',
                        rightbutton: 'Deny',
                        onLeftButtonPressed: () {
                          handleRequest(driverRequests[i]['id'], true, i);
                        },
                        leftButtonStyle: const TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        onRightButtonPressed: () {
                          handleRequest(driverRequests[i]['id'], false, i);
                        },
                        rightButtonStyle: const TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
