import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentAttendanceScreen extends StatefulWidget {
  @override
  _StudentAttendanceScreenState createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<String, double> subjectAttendance = {
    'Mathematics': 0.72,
    'Physics': 0.87,
    'Chemistry': 0.77,
    'AI': 0.81,
    'English': 0.83,
    'CS': 1.00,
    'Electronics': 0.0,
    'Electrical': 0.0,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color getAttendanceColor(double attendance) {
    if (attendance >= 0.85) return Colors.green;
    if (attendance >= 0.75) return Colors.yellow;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'By Subject'), Tab(text: 'By Day')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // By Subject View
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: subjectAttendance.length,
                    itemBuilder: (context, index) {
                      String subject = subjectAttendance.keys.elementAt(index);
                      double attendance = subjectAttendance[subject]!;
                      String attendanceText =
                          attendance == 0.0
                              ? "N/A"
                              : "${(attendance * 100).toStringAsFixed(0)}%";

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subject,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      attendance == 0.0
                                          ? 'No attendance data available'
                                          : 'Attendance: $attendanceText',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                height: 70,
                                child:
                                    attendance == 0.0
                                        ? Text('N/A')
                                        : Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CircularProgressIndicator(
                                              value: attendance,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    getAttendanceColor(
                                                      attendance,
                                                    ),
                                                  ),
                                              strokeWidth: 8,
                                            ),
                                            Center(
                                              child: Text(
                                                attendanceText,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // By Day View (Calendar Implementation)
          Column(
            children: [
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(DateTime.now().year - 1),
                lastDay: DateTime(DateTime.now().year + 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Selected Date: ${_selectedDay!.toLocal()}",
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a date.")),
                    );
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
