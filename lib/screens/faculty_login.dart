import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'faculty_home.dart';

class FacultyLoginScreen extends StatefulWidget {
  const FacultyLoginScreen({super.key});

  @override
  FacultyLoginScreenState createState() => FacultyLoginScreenState();
}

class FacultyLoginScreenState extends State<FacultyLoginScreen> {
  final TextEditingController _facultyNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();

    String facultyNo = _facultyNoController.text.trim();
    String password = _passwordController.text.trim();

    String? facultyData = prefs.getString(facultyNo);

    if (facultyData != null) {
      try {
        Map<String, dynamic> facultyInfo = jsonDecode(facultyData);

        if (facultyInfo['password'] == password) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successful!")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FacultyHomeScreen(facultyInfo: facultyInfo),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid Password!")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error decoding data!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Faculty not found!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _facultyNoController,
              decoration: const InputDecoration(labelText: 'Faculty No'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
