import 'package:flutter/material.dart';
import 'student_login.dart';
import 'faculty_login.dart';
import 'admin_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLoginScreen()));
              },
              child: Text('Student Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyLoginScreen()));
              },
              child: Text('Faculty Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));
              },
              child: Text('Administrator Login'),
            ),
          ],
        ),
      ),
    );
  }
}
