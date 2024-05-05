import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/google_signin.dart';
import 'package:mobile/components/my_button.dart';
import 'package:mobile/components/my_textfield.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signup(String firstname, lastname, email, password, BuildContext context) async{
  try {
    final response = await http.post(
      Uri.parse('http://192.168.1.106:8000/api/register'),
      body: {
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password,
      }
    );
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/userhome');
    } else {
        print('failed');
      }
    } catch(e) {
      print(e.toString());
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
                    Navigator.pushNamed(context, '/userhome');
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
