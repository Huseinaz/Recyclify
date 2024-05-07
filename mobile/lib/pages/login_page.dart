import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/google_signin.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_textfield.dart';
import 'package:mobile/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(String email, password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('$HOST/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final token = jsonData['authorisation']['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(KEY_ACCESS_TOKEN, token);

      final roleId = jsonData['user']['role_id'];
      if (roleId == 2) {
        Navigator.pushNamed(context, '/userhome');
      } else if (roleId == 3) {
        Navigator.pushNamed(context, '/driverhome');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid email or password. Please try again.'),
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
                const SizedBox(height: 40),

                const Image(
                  image: AssetImage('assets/image/logo-bg-gray.png'),
                  height: 118,
                  width: 118,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Log In',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),

                const SizedBox(height: 40),

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

                const SizedBox(height: 100),

                //login button
                MyButton(
                  onTap: () {
                    login(emailController.text.toString(), passwordController.text.toString(), context);
                  },
                  buttonText: 'Log In',
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
                    Navigator.pushNamed(context, '/driverhome');
                  },
                ),

                const SizedBox(height: 10),

                //don't have an acount
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Register now',
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
