import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';
import '../widgets/main_drawer.dart';

// import '../widgets/calendar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<DateTime, List<Task>> scheduledTasks;

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    scheduledTasks = {};
    super.initState();
  }

  List<Task> _getTasksForDay(DateTime date) {
    return scheduledTasks[date] ?? [];
  }

  TextEditingController _taskController = TextEditingController();
  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
        ),
        elevation: 25,
        shadowColor: Theme.of(context).accentColor,
        title: Text('Главная'),
      ),
      drawer: MainDrawer(),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   // color: Colors.amber,
                  //   border: Border.all(
                  //     // color: Colors.black,
                  //     width: 11,
                  //   ),
                  // ),
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 0.7,
                    strokeWidth: 19.0,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Text(
                  '33/52',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                )
              ],
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 392,
            //   child:
            TableCalendar(
              availableCalendarFormats: const {
                CalendarFormat.month: 'Месяц',
                CalendarFormat.twoWeeks: '14 дней',
                CalendarFormat.week: '7 дней'
              },
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              startingDayOfWeek: StartingDayOfWeek.monday,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay`
                });
                print(focusedDay);
              },
              eventLoader: _getTasksForDay,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red[900],
                ),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
                formatButtonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context)
                      .primaryColor
                      .withAlpha(90), //Color(0xFF72B076),
                ),
                formatButtonTextStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF5C6BC0),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 10.0,
                      //     offset: Offset(-3.0, 3.0),
                      //   ),
                      // ],
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF9FA8DA),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              locale: 'ru_RU',
            ),
            ..._getTasksForDay(_selectedDay).map(
              (Task task) => ListTile(
                title: Text(
                  task.title,
                ),
              ),
            ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text('Новая задача'),
                content: TextFormField(
                  controller: _taskController,
                ),
                actions: [
                  TextButton(
                    child: Text('Отмена'),
                    onPressed: Navigator.of(context).pop,
                  ),
                  TextButton(
                    child: Text('Ок'),
                    onPressed: () {
                      if (_taskController.text.isEmpty) {
                      } else {
                        if (scheduledTasks[_selectedDay] != null) {
                          scheduledTasks[_selectedDay]
                              .add(Task(title: _taskController.text));
                        } else {
                          scheduledTasks[_selectedDay] = [
                            Task(title: _taskController.text)
                          ];
                        }
                      }
                      Navigator.pop(context);
                      _taskController.clear();
                      setState(() {});
                      return;
                    },
                  ),
                ]),
          );
        },
        label: Text(
          'Задача',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        icon: Icon(
          Icons.add_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
