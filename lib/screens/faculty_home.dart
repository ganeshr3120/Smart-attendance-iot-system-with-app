import 'package:flutter/material.dart';

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
              Text(
                'Class Assigned: ${facultyInfo['facultyClass']}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Subjects:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...facultyInfo['subjects']
                  .map<Widget>(
                    (subject) =>
                        Text('• $subject', style: TextStyle(fontSize: 14)),
                  )
                  .toList(),
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
      ),
    );
  }
}
