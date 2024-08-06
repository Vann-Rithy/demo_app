import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0), // Padding around the calendar
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return _buildCustomDay(day);
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return _buildCustomDay(day, isToday: true);
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return _buildCustomDay(day, isSelected: true);
                    },
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) {
                      return _getKhmerDayText(date.weekday);
                    },
                    weekdayStyle: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        8.0), // Space between days of the week and calendar days
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: _selectedDay != null
                ? ListView(
                    children: _getEventsForDay(_selectedDay)
                        .map(
                          (event) => ListTile(
                            title: Text(event.title),
                          ),
                        )
                        .toList(),
                  )
                : Center(
                    child: Text('No events selected'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDay(DateTime day,
      {bool isToday = false, bool isSelected = false}) {
    String customText = _getCustomTextForDay(day);

    return Container(
      margin: const EdgeInsets.all(2.0), // Margin between days
      decoration: BoxDecoration(
        color:
            isSelected ? Colors.blue : (isToday ? Colors.green : Colors.white),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 16.0,
              color: isSelected || isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (customText.isNotEmpty)
            Text(
              customText,
              style: TextStyle(
                fontSize: 10.0,
                color: isSelected || isToday ? Colors.white : Colors.black,
              ),
            ),
          if (_isBuddhistSabbath(day))
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Image.asset(
                'assets/pngwing.com (3).png',
                width: 12,
                height: 12,
              ),
            ),
        ],
      ),
    );
  }

  String _getCustomTextForDay(DateTime day) {
    final customTexts = {
      8: '៨ រោច',
      14: '១៤ រោច',
      15: '១៥ រោច',
    };
    return customTexts[day.day] ?? '';
  }

  List<Event> _getEventsForDay(DateTime? day) {
    return _events[day] ?? [];
  }

  String _getKhmerDayText(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'ចន្ទ';
      case DateTime.tuesday:
        return 'អង្គារ';
      case DateTime.wednesday:
        return 'ពុធ';
      case DateTime.thursday:
        return 'ព្រហស្បតិ៍';
      case DateTime.friday:
        return 'សុក្រ';
      case DateTime.saturday:
        return 'សៅរ៍';
      case DateTime.sunday:
      default:
        return 'អាទិត្យ';
    }
  }

  bool _isBuddhistSabbath(DateTime day) {
    return day.day % 8 == 0;
  }
}

class Event {
  final String title;

  const Event(this.title);
}
