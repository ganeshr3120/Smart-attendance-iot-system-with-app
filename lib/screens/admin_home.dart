import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_student_screen.dart';
import 'add_faculty_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  Future<void> _resetAttendance(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // Clears all stored data (Optional: Keep login details)

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All attendance records have been reset!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudentScreen()),
                );
              },
              child: Text('Add Student'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFacultyScreen()),
                );
              },
              child: Text('Add Faculty'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _resetAttendance(context),
              child: Text('Reset Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
