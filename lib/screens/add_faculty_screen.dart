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

  final List<String> _selectedClasses = []; // Holds the selected classes
  final List<String> _selectedSubjects = []; // Holds the selected subjects

  // Predefined list of classes
  final List<String> _availableClasses = ['ER', 'EEE', 'EC', 'MECH', 'CS'];

  // Predefined list of subjects
  final List<String> _availableSubjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'AI',
    'English',
    'CS',
    'Electronics',
    'Electrical',
  ];

  Future<void> _addFaculty() async {
    final prefs = await SharedPreferences.getInstance();

    String name = _nameController.text.trim();
    String facultyNo = _facultyNoController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty ||
        facultyNo.isEmpty ||
        password.isEmpty ||
        _selectedClasses.isEmpty ||
        _selectedSubjects.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required!")));
      return;
    }

    Map<String, dynamic> facultyData = {
      'name': name,
      'facultyNo': facultyNo,
      'facultyClasses': _selectedClasses, // Store multiple selected classes
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
      _selectedClasses.clear();
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
            Text(
              'Select Classes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children:
                  _availableClasses.map((classItem) {
                    return ChoiceChip(
                      label: Text(classItem),
                      selected: _selectedClasses.contains(classItem),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedClasses.add(classItem);
                          } else {
                            _selectedClasses.remove(classItem);
                          }
                        });
                      },
                    );
                  }).toList(),
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
