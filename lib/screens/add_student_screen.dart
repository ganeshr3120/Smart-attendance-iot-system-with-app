import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _rfidController = TextEditingController();

  String? _selectedBranch; // Holds the selected branch

  // List of available branches
  final List<String> branches = ['ER', 'EEE', 'EC', 'MECH', 'CS'];

  Future<void> _saveStudent() async {
    final prefs = await SharedPreferences.getInstance();

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String email = _emailId.text.trim();
    String name = _nameController.text.trim();
    String rollNo = _rollNoController.text.trim();
    String rfid = _rfidController.text.trim();

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        email.isNotEmpty &&
        rollNo.isNotEmpty &&
        _selectedBranch != null) {
      // Store student details properly
      await prefs.setString('${username}_password', password);
      await prefs.setString('${username}_name', name);
      await prefs.setString('${username}_rollNo', rollNo);
      await prefs.setString('${username}_branch', _selectedBranch!);
      await prefs.setString('${username}_rfid', rfid);
      await prefs.setString('${username}_rfid', email);

      // Initialize attendance
      await prefs.setInt('${username}_total_classes', 0);
      await prefs.setInt('${username}_attended_classes', 0);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Student Added Successfully!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _rollNoController,
              decoration: InputDecoration(labelText: 'Roll No'),
            ),
            // Dropdown for Branch Selection
            DropdownButtonFormField<String>(
              value: _selectedBranch,
              decoration: InputDecoration(labelText: 'Select Branch'),
              items:
                  branches.map((branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedBranch = newValue;
                });
              },
            ),
            TextField(
              controller: _emailId,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Set Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Set Password'),
              obscureText: true,
            ),
            TextField(
              controller: _rfidController,
              decoration: InputDecoration(labelText: 'RFID No'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveStudent, child: Text('Add Student')),
          ],
        ),
      ),
    );
  }
}
