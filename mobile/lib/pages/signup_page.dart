import 'package:flutter/material.dart';
import 'package:mobile/components/google_signin.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_textfield.dart';
import 'package:mobile/pages/login_page.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      body: SafeArea(
        child: Center(
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
                'Sign Up',
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

              const SizedBox(height: 15),

              //password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              //login button
              MyButton(
                onTap: signUserIn,
                buttonText: 'Sign Up',
              ),

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

              GoogleSignin(onTap: signUserIn),

              const SizedBox(height: 20),

              //registen now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
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
    );
  }
}
