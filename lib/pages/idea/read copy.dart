import 'package:flutter/material.dart';
import 'detail_page.dart'; // Import the detail page
import 'package:http/http.dart' as http;
import 'dart:convert';

class readpage extends StatelessWidget {
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
        title: Text('អានអត្ថបទ', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background_app.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.search, color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip('សាសនាព្រះពុទ្ធ'),
                  _buildCategoryChip('សាសនាកាតូលិក'),
                  _buildCategoryChip('សាសនាឥស្លាម'),
                  _buildCategoryChip('ព្យាករណ៍សាស្រ្ដ'),
                  // Add more categories here
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchPosts(), // Fetch posts from the server
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No posts available'));
                  } else {
                    final posts = snapshot.data!;
                    return ListView(
                      padding: EdgeInsets.all(8.0),
                      children: posts.map((post) {
                        return ListCard(
                          imagePath: post['image_path'],
                          title: post['title'],
                          description: post['description'],
                          id: post['id'].toString(),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Color(0xFFFFC107), // Yellow color for the chip
        labelStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://api.plexustrust.net/dashboard/get_posts.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

class ListCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String id;

  ListCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://api.plexustrust.net/dashboard/$imagePath'; // Construct the full URL

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Color(0xFFFFC107),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            imageUrl,
            width: 100,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error); // Fallback icon in case of an error
            },
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: int.parse(id),
              ),
            ),
          );
        },
      ),
    );
  }
}
