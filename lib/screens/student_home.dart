import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  String studentName = "Loading...";
  String rollNo = "Loading...";
  double attendancePercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  Future<void> _loadStudentData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      studentName = prefs.getString('student_name') ?? "Unknown";
      rollNo = prefs.getString('student_rollNo') ?? "N/A";

      int totalClasses = prefs.getInt('total_classes') ?? 1;
      int attendedClasses = prefs.getInt('attended_classes') ?? 0;

      attendancePercentage = (attendedClasses / totalClasses) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Student Name: $studentName"),
            Text("Roll No: $rollNo"),
            Text("Attendance: ${attendancePercentage.toStringAsFixed(2)}%"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement View Attendance Navigation
              },
              child: Text("View Attendance"),
            ),
          ],
        ),
      ),
    );
  }
}
