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

  @override
  void initState() {
    super.initState();
    fetchContainers();
  }

  Future<void> fetchContainers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.get(
      Uri.parse('http://192.168.1.106:8000/api/containers'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        containers = List<Map<String, dynamic>>.from(jsonDecode(response.body)['containers']);
      });
    } else {
      print('Failed to load containers data');
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
        ),
      ),

      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var container in containers)
                          MyContainer(
                            color: MyContainer.getColorFromType(container['type']['name']),
                            type: container['type']['name'],
                            percentage: container['capacity'],
                          ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                MyButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/driverhome');
                  },
                  buttonText: 'Request a driver',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }
}