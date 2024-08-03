import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Found'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'មិនមានទិន្នន័យ',
          style: TextStyle(fontSize: 24, color: Colors.red),
        ),
      ),
    );
  }
}
