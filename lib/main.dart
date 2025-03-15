import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/login_screen.dart';
import 'screens/student_login.dart';
import 'screens/faculty_login.dart';
import 'screens/admin_login.dart';
import 'screens/student_home.dart';
import 'screens/faculty_home.dart';
import 'screens/admin_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/studentLogin': (context) => StudentLoginScreen(),
        '/facultyLogin': (context) => FacultyLoginScreen(),
        '/adminLogin': (context) => AdminLoginScreen(),
        '/studentHome': (context) => StudentHomeScreen(),
        '/facultyHome': (context) => FacultyHomeScreen(),
        '/adminHome': (context) => AdminHomeScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
