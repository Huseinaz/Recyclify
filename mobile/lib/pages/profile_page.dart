import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/logout_button.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/consts.dart';
import 'package:mobile/components/profile_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> profile = [];
  String name = '';
  String email = '';
  String profilePicture = '';
  String password = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    final response = await http.get(
      Uri.parse('$HOST/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(response.body);

      setState(() {
        name = jsonData['user']['first_name'] +
            ' ' +
            jsonData['user']['last_name'];
        email = jsonData['user']['email'];
        profilePicture = jsonData['user']['profile_picture'];
      });
    } else {
      print('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF187B1B),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          LogoutButton(),
        ],
      ),
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    color: const Color(0xFF187B1B),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 75,
                          backgroundImage:
                              AssetImage('assets/image/profile.png'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ProfileData(
                      label: 'Full Name',
                      data: name,
                    ),
                    const SizedBox(height: 20),
                    ProfileData(
                      label: 'Email',
                      data: email,
                    ),
                    const SizedBox(height: 20),
                    const ProfileData(
                      label: 'Password',
                      data: '********',
                    ),
                    const SizedBox(height: 20),
                    const ProfileData(
                      label: 'Address',
                      data: 'Beirut, Lebanon',
                    ),
                    const SizedBox(height: 80),
                    MyButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                      buttonText: 'Save',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
