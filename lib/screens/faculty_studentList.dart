import 'package:flutter/material.dart';

class FacultyStudentListScreen extends StatelessWidget {
  // Sample student data
  final List<Map<String, String>> students = [
    {'name': 'John Doe', 'id': 'S101'},
    {'name': 'Jane Smith', 'id': 'S102'},
    {'name': 'Robert Brown', 'id': 'S103'},
    {'name': 'Emily Davis', 'id': 'S104'},
  ];

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
              ElevatedButton(
                onPressed: () {
                  // Handle class selection
                  print("Class Selected");
                },
                child: Text('Select Class'),
              ),
              SizedBox(width: 20), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Handle subject selection
                  print("Subject Selected");
                },
                child: Text('Select Subject'),
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
