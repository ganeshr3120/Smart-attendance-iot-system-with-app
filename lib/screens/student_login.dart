import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'student_home.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    String? savedPassword = prefs.getString(
      '${username}_password',
    ); // Get saved password
    String studentName =
        prefs.getString('${username}_name') ??
        ''; // Get student name or default to empty string
    String rollNo =
        prefs.getString('${username}_rollNo') ??
        ''; // Get roll number or default to empty string

    if (savedPassword == password) {
      // Save student details for Home Screen
      await prefs.setString('student_name', studentName);
      await prefs.setString('student_rollNo', rollNo);

      // Initialize attendance if not set
      if (!prefs.containsKey('${username}_total_classes')) {
        await prefs.setInt('${username}_total_classes', 0);
      }
      if (!prefs.containsKey('${username}_attended_classes')) {
        await prefs.setInt('${username}_attended_classes', 0);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StudentHomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid Username or Password!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
