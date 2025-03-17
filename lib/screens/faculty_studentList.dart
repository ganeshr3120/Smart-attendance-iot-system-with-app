import 'package:flutter/material.dart';

class FacultyStudentListScreen extends StatefulWidget {
  @override
  _FacultyStudentListScreenState createState() =>
      _FacultyStudentListScreenState();
}

class _FacultyStudentListScreenState extends State<FacultyStudentListScreen> {
  // Sample student data
  final List<Map<String, String>> students = [
    {'name': 'John Doe', 'id': 'S101'},
    {'name': 'Jane Smith', 'id': 'S102'},
    {'name': 'Robert Brown', 'id': 'S103'},
    {'name': 'Emily Davis', 'id': 'S104'},
  ];

  // Sample class and subject data
  final List<String> classes = ['ER', 'EEE', 'MECH', 'CS', 'EC'];
  final List<String> subjects = ['Math', 'Science', 'History'];

  String? selectedClass;
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student List')),
      body: Column(
        children: [
          SizedBox(height: 20), // Spacing from top
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: Text('Select Class'),
                value: selectedClass,
                onChanged: (newValue) {
                  setState(() {
                    selectedClass = newValue;
                  });
                },
                items:
                    classes.map((String className) {
                      return DropdownMenuItem<String>(
                        value: className,
                        child: Text(className),
                      );
                    }).toList(),
              ),
              SizedBox(width: 20), // Spacing between dropdowns
              DropdownButton<String>(
                hint: Text('Select Subject'),
                value: selectedSubject,
                onChanged: (newValue) {
                  setState(() {
                    selectedSubject = newValue;
                  });
                },
                items:
                    subjects.map((String subjectName) {
                      return DropdownMenuItem<String>(
                        value: subjectName,
                        child: Text(subjectName),
                      );
                    }).toList(),
              ),
            ],
          ),
          SizedBox(height: 20), // Spacing before student list
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(students[index]['name']![0]),
                    ),
                    title: Text(students[index]['name']!),
                    subtitle: Text('ID: ${students[index]['id']}'),
                    onTap: () {
                      // Handle student selection
                      print("Selected: ${students[index]['name']}");
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
