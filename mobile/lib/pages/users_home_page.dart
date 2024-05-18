import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/components/animated_bin.dart';
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
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchContainers();
  }

  Future<void> fetchContainers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    if (token == null || token.isEmpty) {
      print('No token found');
      setState(() {
        isLoading = false;
      });
      return;
    }

    final response = await http.get(
      Uri.parse('$HOST/containers'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data['containers'] != null) {
        setState(() {
          containers = List<Map<String, dynamic>>.from(data['containers']);
          isLoading = false;
        });
      } else {
        print('No containers found in response');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Failed to load containers data');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshContainers() async {
    setState(() {
      isLoading = true;
    });
    await fetchContainers();
  }

  Future<void> sendDriverRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(KEY_ACCESS_TOKEN);

    if (token == null || token.isEmpty) {
      print('No token found');
      return;
    }

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

  void _onArrowTapped(int direction) {
    int newPage = _currentPage + direction;
    if (newPage >= 0 && newPage < containers.length + 1) {
      _pageController.animateToPage(
        newPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = newPage;
      });
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
            : Column(
                children: [
                  const SizedBox(height: 40),
                  Expanded(
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: containers.length + 1,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return ListView.builder(
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
                              );
                            } else {
                              final container = containers[index - 1];
                              final type = container['type']?['name'] ?? 'Unknown';
                              final percentage = container['capacity'] ?? 0;

                              return Center(
                                child: AnimatedBin(
                                  color: MyContainer.getColorFromType(type),
                                  type: type,
                                  percentage: percentage,
                                ),
                              );
                            }
                          },
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              containers.length + 1,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
    );
  }
}
