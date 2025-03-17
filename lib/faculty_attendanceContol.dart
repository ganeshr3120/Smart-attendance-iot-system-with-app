import 'package:flutter/material.dart';

class FacultyAttendanceControlScreen extends StatefulWidget {
  const FacultyAttendanceControlScreen({super.key});

  @override
  _FacultyAttendanceControlScreenState createState() =>
      _FacultyAttendanceControlScreenState();
}

class _FacultyAttendanceControlScreenState
    extends State<FacultyAttendanceControlScreen> {
  String? selectedClass;
  String? selectedSubject;
  String? selectedTimeSlot;

  List<String> classes = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];
  List<String> subjects = ['Math', 'Science', 'English', 'History'];
  List<String> timeSlots = [
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
  ];

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
                  classes.map((cls) {
                    return DropdownMenuItem(value: cls, child: Text(cls));
                  }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedSubject,
              hint: Text('Select Subject'),
              onChanged: (value) => setState(() => selectedSubject = value),
              items:
                  subjects.map((subj) {
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
                        'Attendance marked for $selectedClass - $selectedSubject at $selectedTimeSlot',
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
              child: Text('Mark Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FacultyAttendanceControlScreen()));
}
