import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddFacultyScreen extends StatefulWidget {
  const AddFacultyScreen({super.key});

  @override
  _AddFacultyScreenState createState() => _AddFacultyScreenState();
}

class _AddFacultyScreenState extends State<AddFacultyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _facultyNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedClass; // Holds the selected class
  final List<String> _selectedSubjects = [];

  // Predefined list of classes
  final List<String> _availableClasses = ['ER', 'EEE', 'EC', 'MECH', 'CS'];

  // Predefined list of subjects
  final List<String> _availableSubjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'English',
    'Computer Science',
    'History',
    'Geography',
  ];

  Future<void> _addFaculty() async {
    final prefs = await SharedPreferences.getInstance();

    String name = _nameController.text.trim();
    String facultyNo = _facultyNoController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty ||
        facultyNo.isEmpty ||
        password.isEmpty ||
        _selectedClass == null ||
        _selectedSubjects.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required!")));
      return;
    }

    Map<String, dynamic> facultyData = {
      'name': name,
      'facultyNo': facultyNo,
      'facultyClass': _selectedClass,
      'password': password,
      'subjects': _selectedSubjects,
    };

    await prefs.setString(facultyNo, jsonEncode(facultyData));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Faculty Added Successfully!")));

    _nameController.clear();
    _facultyNoController.clear();
    _passwordController.clear();
    setState(() {
      _selectedClass = null;
      _selectedSubjects.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Faculty')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Faculty Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _facultyNoController,
              decoration: InputDecoration(labelText: 'Faculty No'),
            ),
            SizedBox(height: 10),
            // Class Selection Dropdown
            DropdownButtonFormField<String>(
              value: _selectedClass,
              decoration: InputDecoration(labelText: 'Select Class'),
              items:
                  _availableClasses.map((classItem) {
                    return DropdownMenuItem<String>(
                      value: classItem,
                      child: Text(classItem),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedClass = newValue;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Text(
              'Subjects Assigned:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children:
                  _availableSubjects.map((subject) {
                    return ChoiceChip(
                      label: Text(subject),
                      selected: _selectedSubjects.contains(subject),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedSubjects.add(subject);
                          } else {
                            _selectedSubjects.remove(subject);
                          }
                        });
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addFaculty, child: Text('Add Faculty')),
          ],
        ),
      ),
    );
  }
}
