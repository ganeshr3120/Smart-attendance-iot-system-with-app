import 'package:flutter/material.dart';

class FacultyHomeScreen extends StatelessWidget {
  const FacultyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Faculty Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Faculty Name: Dr. Smith'),
            Text('Staff No: 7890'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to attendance control
              },
              child: Text('Attendance Control'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to student list
              },
              child: Text('Student List'),
            ),
          ],
        ),
      ),
    );
  }
}
