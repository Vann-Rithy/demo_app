import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page.dart'; // Import the detail page

class readpage extends StatefulWidget {
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<readpage> {
  late Future<List<Map<String, dynamic>>> _postsFuture;
  List<Map<String, dynamic>> _allPosts = [];
  List<Map<String, dynamic>> _filteredPosts = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsFuture = _fetchPosts();
  }

  Future<List<Map<String, dynamic>>> _fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://api.plexustrust.net/dashboard/get_posts.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _allPosts = data.cast<Map<String, dynamic>>();
      _filterPosts();
      return _allPosts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  void _refreshData() {
    setState(() {
      _postsFuture = _fetchPosts();
    });
  }

  void _filterPosts() {
    setState(() {
      _filteredPosts = _allPosts.where((post) {
        return post['title']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            post['description']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _onSearchButtonPressed() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterPosts();
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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          hintText: 'ស្វែងរក...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _onSearchButtonPressed,
                    child: Icon(Icons.search), // Only icon in the button
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16.0),
                    ),
                  ),
                ],
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
                future: _postsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || _filteredPosts.isEmpty) {
                    return Center(child: Text('មិនមានទិន្នន័យ'));
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        _refreshData();
                      },
                      child: ListView(
                        padding: EdgeInsets.all(8.0),
                        children: _filteredPosts.map((post) {
                          return ListCard(
                            imagePath: post['image_path'],
                            title: post['title'],
                            description: post['description'],
                            id: post['id'].toString(),
                          );
                        }).toList(),
                      ),
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
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
