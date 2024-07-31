import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text('ប្រតិទិន',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
              ),
            ),
            // Display days of the week
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildDayCard('ចន្ទ'),
                  _buildDayCard('អង្គារ'),
                  _buildDayCard('ពុធ'),
                  _buildDayCard('ព្រហ'),
                  _buildDayCard('សុក្រ'),
                  _buildDayCard('សៅរ៍'),
                  _buildDayCard('អាទិ'),
                ],
              ),
            ),
            // Add calendar days (example)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 30, // Example: 30 days
                itemBuilder: (context, index) {
                  bool isToday =
                      index == DateTime.now().day - 1; // Highlight today's date
                  return Card(
                    color: isToday ? Colors.amberAccent : Colors.white,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(String dayName) {
    return Expanded(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(dayName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
