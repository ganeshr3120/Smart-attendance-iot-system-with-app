import 'package:flutter/material.dart';

class FacultyAttendanceControlScreen extends StatelessWidget {
  const FacultyAttendanceControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Control')),
      body: Center(
        child: Text(
          'This is the Attendance Control Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
