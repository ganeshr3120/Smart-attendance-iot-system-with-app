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
      setState(() {
        attendanceData = List<Map<String, dynamic>>.from(
          jsonDecode(attendanceJson),
        );
      });
    } else {
      setState(() {
        attendanceData = [
          {
            'subject': 'Power Electronics and Drives',
            'attended': 26,
            'total': 29,
          },
          {'subject': 'Internet of Things', 'attended': 36, 'total': 43},
          {'subject': 'Electrical Machines', 'attended': 33, 'total': 39},
          {
            'subject': 'Industrial Economics and Foreign Trade',
            'attended': 20,
            'total': 22,
          },
          {'subject': 'Embedded Systems & IoT Lab', 'attended': 9, 'total': 12},
        ];
      });
    }
  }

  double _calculatePercentage(int attended, int total) {
    return (attended / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Column(
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
                      percent: percentage / 100,
                      center: Text('${percentage.toInt()}%'),
                      progressColor:
                          percentage >= 85
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
