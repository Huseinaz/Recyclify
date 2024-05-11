import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/request_container.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
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

                for (var request in driverRequests)
                Column(
                  children: [
                    RequestContainer(
                      name: request['user']['first_name'] + ' ' + request['user']['last_name'],
                      address: 'Beirut, Lebanon',
                      onAccept: () {
                        print('Accept request');
                      },
                      onReject: () {
                        print('Reject request');
                      },
                    ),
                    const SizedBox(height: 10), // Adjust the height as needed
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
