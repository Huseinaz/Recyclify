import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await logoutUser(context);
      },
    );
  }

  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);
    var response = await http.post(
      Uri.parse('$HOST/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      prefs.remove('id');
      prefs.remove('email');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      throw Exception('Failed to logout');
    }
  }
}
