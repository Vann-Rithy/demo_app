import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_detail.dart'; // Import the detail page

class bookpage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<bookpage> {
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
        .get(Uri.parse('https://api.plexustrust.net/dashboard/get_books.php'));
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
        title: Text('បណ្ដុំឯកសារ', style: TextStyle(color: Colors.red)),
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
                      child: GridView.builder(
                        padding: EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: _filteredPosts.length,
                        itemBuilder: (context, index) {
                          return ListCard(
                            imagePath: _filteredPosts[index]['thumbnail_path'],
                            title: _filteredPosts[index]['title'],
                            id: _filteredPosts[index]['id'].toString(),
                          );
                        },
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
  final String id;

  ListCard({
    required this.imagePath,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://api.plexustrust.net/dashboard/$imagePath'; // Construct the full URL

    return GestureDetector(
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                        Icons.error); // Fallback icon in case of an error
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
