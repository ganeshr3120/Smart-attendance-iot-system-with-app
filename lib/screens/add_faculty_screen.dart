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
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> _selectedSubjects = [];

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
    String facultyClass = _classController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty ||
        facultyNo.isEmpty ||
        facultyClass.isEmpty ||
        password.isEmpty ||
        _selectedSubjects.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required!")));
      return;
    }

    Map<String, dynamic> facultyData = {
      'name': name,
      'facultyNo': facultyNo,
      'facultyClass': facultyClass,
      'password': password,
      'subjects': _selectedSubjects,
    };

    await prefs.setString(facultyNo, jsonEncode(facultyData));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Faculty Added Successfully!")));

    _nameController.clear();
    _facultyNoController.clear();
    _classController.clear();
    _passwordController.clear();
    setState(() {
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
          mainAxisAlignment: MainAxisAlignment.center,
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
            TextField(
              controller: _classController,
              decoration: InputDecoration(labelText: 'Class Assigned'),
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
