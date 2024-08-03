import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    _postFuture = _fetchPostDetails(widget.id);
    _postFuture.then((post) {
      setState(() {
        _title = post['title'];
      });
    });
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
        // Ensure font size does not go below 12
        _fontSize -= 2; // Decrease font size by 2
      }
    });
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
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details available'));
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
                    Hero(
                      tag:
                          'image-${widget.id}', // Ensure tag matches with ListCard
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Apply only border radius
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          'https://api.plexustrust.net/dashboard/${post['image_path']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                    // Add more details as needed
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
    final response = await http.get(Uri.parse(
        'https://api.plexustrust.net/dashboard/get_post_detail.php?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post details');
    }
  }
}
