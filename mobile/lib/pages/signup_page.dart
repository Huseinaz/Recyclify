import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/google_signin.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_textfield.dart';
import 'package:mobile/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
  }

  void signup(String firstname, lastname, email, password, BuildContext context) async {
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    
    String? fcmToken = await getFcmToken();

    String fullName = '$firstname $lastname';

    final response = await http.post(
      Uri.parse('$HOST/register'),
      body: {
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password,
        'fcmtoken':fcmToken,
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final token = jsonData['authorisation']['token'];
      final userId = jsonData['user']['id'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(KEY_ACCESS_TOKEN, token);
      await prefs.setString(KEY_USER_EMAIL, email);
      await prefs.setInt(KEY_USER_ID, userId);
      await prefs.setString(KEY_USER_NAME, fullName);
        
      Navigator.pushNamed(context, '/userhome');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId.toString())
          .set({
        'name' : fullName,
        'email': email,
        'id': userId,
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Up Failed'),
            content: const Text('Failed to sign up. Please try again.'),
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
  } catch (e) {
    print(e.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again later.'),
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
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                const Image(
                  image: AssetImage('assets/image/logo-bg-gray.png'),
                  height: 118,
                  width: 118,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),

                const SizedBox(height: 30),

                //first name textfield
                MyTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),

                const SizedBox(height: 5),

                //last name textfield
                MyTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                const SizedBox(height: 5),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 5),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                //signup button
                MyButton(
                  onTap: () {
                    signup(firstNameController.text.toString(), lastNameController.text.toString(),emailController.text.toString(), passwordController.text.toString(), context);
                  },
                  buttonText: 'Sign Up',
                ),

                const SizedBox(height: 3),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 3),

                GoogleSignin(
                  onTap: () {
                    null;
                  },
                ),

                const SizedBox(height: 10),

                //have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF187B1B),
                        ),
                      ),
                    ),
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
