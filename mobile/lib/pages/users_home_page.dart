import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_container.dart';
import 'package:mobile/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<Map<String, dynamic>> containers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContainers();
  }

  Future<void> fetchContainers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.get(
      Uri.parse('$HOST/containers'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        containers = List<Map<String, dynamic>>.from(
            jsonDecode(response.body)['containers']);
        isLoading = false;
      });
    } else {
      print('Failed to load containers data');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> sendDriverRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.post(
      Uri.parse('$HOST/driverRequest'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Driver request sent successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to send driver request!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Your Container',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.track_changes),
              onPressed: () {
                Navigator.pushNamed(context, '/tracking');
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ))
            : Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Expanded(
                      child: ListView.builder(
                        itemCount: containers.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return MyContainer(
                              color: MyContainer.getColorFromType(
                                  containers[index]['type']['name']),
                              type: containers[index]['type']['name'],
                              percentage: containers[index]['capacity'],
                            );
                          } else {
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                MyContainer(
                                  color: MyContainer.getColorFromType(
                                      containers[index]['type']['name']),
                                  type: containers[index]['type']['name'],
                                  percentage: containers[index]['capacity'],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    MyButton(
                      onTap: () {
                        sendDriverRequest();
                      },
                      buttonText: 'Request a driver',
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
      ),
    );
  }
}
