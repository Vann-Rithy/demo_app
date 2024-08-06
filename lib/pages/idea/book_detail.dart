import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'NotFoundPage.dart';

class DetailPage extends StatefulWidget {
  final int id;

  DetailPage({required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> _postFuture;
  String _title = '';
  double _fontSize = 16.0; // Default font size for description
  String _pdfUrl = '';
  String? _pdfFilePath;
  int _currentPage = 0;
  int _totalPages = 0;
  PDFViewController? _pdfViewController;
  TextEditingController _pageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postFuture = _fetchPostDetails(widget.id);
    _postFuture.then((post) {
      setState(() {
        _title = post['title'];
        _pdfUrl =
            'https://api.plexustrust.net/dashboard/${post['pdf_path']}'; // Use the PDF path from the response
        _downloadPdf(_pdfUrl);
      });
    }).catchError((error) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NotFoundPage()),
      );
    });
  }

  Future<void> _downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/downloaded.pdf');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _pdfFilePath = file.path;
        });
      } else {
        print('Failed to download PDF');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  void _increaseFontSize() {
    setState(() {
      if (_fontSize < 40) {
        _fontSize += 2; // Increase font size by 2
      }
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 12) {
        _fontSize -= 2; // Decrease font size by 2
      }
    });
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _currentPage++;
      _pdfViewController?.setPage(_currentPage);
      _pageController.text = (_currentPage + 1).toString();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pdfViewController?.setPage(_currentPage);
      _pageController.text = (_currentPage + 1).toString();
    }
  }

  void _jumpToPage() {
    int? page = int.tryParse(_pageController.text);
    if (page != null && page > 0 && page <= _totalPages) {
      _pdfViewController?.setPage(page - 1);
      setState(() {
        _currentPage = page - 1;
      });
    }
  }

  void _downloadFile() async {
    // Show the progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('កំពុងទាញ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Downloading...'),
            ],
          ),
        );
      },
    );

    try {
      final url = _pdfUrl;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Ask the user to choose the directory
        String? outputPath = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Select directory to save file',
        );

        if (outputPath != null) {
          // Specify the filename
          String fileName =
              'downloaded_${DateTime.now().millisecondsSinceEpoch}.pdf';
          final file = File('$outputPath/$fileName');
          await file.writeAsBytes(response.bodyBytes);

          // Hide the progress dialog
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File downloaded to ${file.path}')),
          );
        } else {
          // Hide the progress dialog if the user cancels the file picker
          Navigator.of(context).pop();
        }
      } else {
        // Hide the progress dialog if the download fails
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download file')),
        );
      }
    } catch (e) {
      // Hide the progress dialog if an error occurs
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/icons_back.png',
            width: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          _title,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadFile,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Navigate to NotFoundPage if no data is returned
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NotFoundPage()),
              );
            });
            return Container(); // Return an empty container while navigating
          } else {
            final post = snapshot.data!;
            final createdAtDate = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(post['created_at']));

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16),
                            SizedBox(width: 8),
                            Text(
                              createdAtDate,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decreaseFontSize,
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _increaseFontSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      post['description'],
                      style: TextStyle(fontSize: _fontSize),
                    ),
                    SizedBox(height: 16),
                    _pdfFilePath != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: _previousPage,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: TextField(
                                      controller: _pageController,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      style: TextStyle(fontSize: 14),
                                      keyboardType: TextInputType.number,
                                      onSubmitted: (value) => _jumpToPage(),
                                    ),
                                  ),
                                  Text(
                                    ' of $_totalPages',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    onPressed: _nextPage,
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 600,
                                child: PDFView(
                                  filePath: _pdfFilePath,
                                  onRender: (pages) {
                                    setState(() {
                                      _totalPages = pages!;
                                    });
                                  },
                                  onViewCreated:
                                      (PDFViewController pdfViewController) {
                                    setState(() {
                                      _pdfViewController = pdfViewController;
                                    });
                                  },
                                  onPageChanged: (currentPage, totalPages) {
                                    setState(() {
                                      _currentPage = currentPage!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchPostDetails(int id) async {
    final url =
        'https://api.plexustrust.net/dashboard/get_books_detail.php?id=$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
