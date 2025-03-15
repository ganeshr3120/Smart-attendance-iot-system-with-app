import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _adminIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Default admin credentials
  final String defaultAdminId = "admin";
  final String defaultAdminPassword = "admin123";

  void _handleLogin() {
    String adminId = _adminIdController.text.trim();
    String password = _passwordController.text.trim();

    if (adminId == defaultAdminId && password == defaultAdminPassword) {
      Navigator.pushNamed(context, '/adminHome');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid Admin ID or Password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _adminIdController,
              decoration: InputDecoration(labelText: 'Admin ID'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _handleLogin, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
