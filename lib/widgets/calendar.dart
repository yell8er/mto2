import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
      body: TableCalendar(
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
                    onPressed: () {},
                  ),
                ]),
          );
        },
        label: Text('Добавить задачу'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
