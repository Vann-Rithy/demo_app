import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfReaderPage extends StatefulWidget {
  final String pdfUrl;

  const PdfReaderPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PdfReaderPageState createState() => _PdfReaderPageState();
}

class _PdfReaderPageState extends State<PdfReaderPage> {
  late Future<Uint8List?> _pdfData;

  @override
  void initState() {
    super.initState();
    _pdfData = _fetchPdf();
  }

  Future<Uint8List?> _fetchPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        // Handle error
        print('Failed to load PDF');
        return null;
      }
    } catch (e) {
      // Handle error
      print('Error fetching PDF: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: FutureBuilder<Uint8List?>(
        future: _pdfData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Error loading PDF'),
            );
          } else {
            return PDFView(
              pdfData: snapshot.data!,
            );
          }
        },
      ),
    );
  }
}
