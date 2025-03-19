import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StudentAttendanceScreen extends StatefulWidget {
  @override
  _StudentAttendanceScreenState createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
  }

  Future<void> _loadAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    String? attendanceJson = prefs.getString('attendanceData');

    if (attendanceJson != null) {
      try {
        List<dynamic> decodedData = jsonDecode(attendanceJson);
        setState(() {
          attendanceData = List<Map<String, dynamic>>.from(decodedData);
        });
      } catch (e) {
        print("Error decoding attendance data: $e");
      }
    } else {
      print("No attendance data found");
    }
  }

  double _calculatePercentage(int attended, int total) {
    if (total == 0) return 0; // Prevent division by zero
    return (attended / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: attendanceData.isEmpty
          ? Center(child: Text('No attendance data available.'))
          : Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: attendanceData.length,
                    itemBuilder: (context, index) {
                      final item = attendanceData[index];
                      double percentage = _calculatePercentage(
                        item['attended'],
                        item['total'],
                      );
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(item['subject']),
                          subtitle: Text(
                            '${item['attended']}/${item['total']} Sessions Attended',
                          ),
                          trailing: CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 5.0,
                            percent: (percentage / 100).clamp(0.0, 1.0),
                            center: Text('${percentage.toInt()}%'),
                            progressColor: percentage >= 85
                                ? Colors.green
                                : (percentage >= 75 ? Colors.orange : Colors.red),
                          ),
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

class CircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final Widget center;
  final Color progressColor;

  CircularPercentIndicator({
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.center,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent,
            strokeWidth: lineWidth,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(progressColor),
          ),
          center,
        ],
      ),
    );
  }
}

