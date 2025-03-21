import 'package:flutter/material.dart';
import 'faculty_studentList.dart'; // Import Student List Screen
import 'package:smart_attendance_system/screens/faculty_attendanceContol.dart'; // Import Attendance Control Screen

class FacultyHomeScreen extends StatelessWidget {
  final Map<String, dynamic> facultyInfo;

  const FacultyHomeScreen({super.key, required this.facultyInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Faculty Home')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Faculty Name: ${facultyInfo['name']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Faculty No: ${facultyInfo['facultyNo']}',
                style: TextStyle(fontSize: 16),
              ),

              // Navigate to Attendance Control Screen with facultyNo
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacultyAttendanceControlScreen(
                        facultyNo: facultyInfo['facultyNo'],
                      ),
                    ),
                  );
                },
                child: Text('Attendance Control'),
              ),

              SizedBox(height: 10),

              // Navigate to Student List Screen
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacultyStudentListScreen(),
                    ),
                  );
                },
                child: Text('Student List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

