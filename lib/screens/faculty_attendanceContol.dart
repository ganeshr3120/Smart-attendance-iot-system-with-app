import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FacultyAttendanceControlScreen extends StatefulWidget {
  final String facultyNo; // Pass faculty number
  const FacultyAttendanceControlScreen({Key? key, required this.facultyNo})
    : super(key: key);

  @override
  _FacultyAttendanceControlScreenState createState() =>
      _FacultyAttendanceControlScreenState();
}

class _FacultyAttendanceControlScreenState
    extends State<FacultyAttendanceControlScreen> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedTimeSlot;

  List<String> assignedClasses = [];
  List<String> assignedSubjects = [];
  List<String> timeSlots = [
    '08:00 AM - 09:00 AM',
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '01:00 PM - 02:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _loadFacultyData();
  }

  Future<void> _loadFacultyData() async {
    final prefs = await SharedPreferences.getInstance();
    String? facultyDataJson = prefs.getString(widget.facultyNo);

    if (facultyDataJson != null) {
      final facultyData = jsonDecode(facultyDataJson);
      setState(() {
        assignedClasses = List<String>.from(facultyData['facultyClasses']);
        assignedSubjects = List<String>.from(facultyData['subjects']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance Control')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedClass,
              hint: Text('Select Class'),
              onChanged: (value) => setState(() => selectedClass = value),
              items:
                  assignedClasses.map((cls) {
                    return DropdownMenuItem(value: cls, child: Text(cls));
                  }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedSubject,
              hint: Text('Select Subject'),
              onChanged: (value) => setState(() => selectedSubject = value),
              items:
                  assignedSubjects.map((subj) {
                    return DropdownMenuItem(value: subj, child: Text(subj));
                  }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedTimeSlot,
              hint: Text('Select Time Slot'),
              onChanged: (value) => setState(() => selectedTimeSlot = value),
              items:
                  timeSlots.map((slot) {
                    return DropdownMenuItem(value: slot, child: Text(slot));
                  }).toList(),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (selectedClass != null &&
                    selectedSubject != null &&
                    selectedTimeSlot != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Attendance started for $selectedClass - $selectedSubject at $selectedTimeSlot',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please select class, subject, and time slot',
                      ),
                    ),
                  );
                }
              },
              child: Text('Start Attendance'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Attendance slot closed')),
                );
              },
              child: Text('Stop Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
