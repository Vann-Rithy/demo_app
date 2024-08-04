import 'package:flutter/material.dart';
import 'pdf_reader_page.dart'; // Import the PDF reader page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfReaderPage(
                  pdfUrl:
                      'https://api.plexustrust.net/dashboard/Books/Building%20APIs%20with%20Node.js.pdf',
                ),
              ),
            );
          },
          child: Text('Open PDF'),
        ),
      ),
    );
  }
}
