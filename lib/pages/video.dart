import 'package:flutter/material.dart';
import 'display_video_page.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          'វីដេអូ',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.red, // Yellow color for the title
          ),
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ស្វែងរក',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                      onPressed: () {
                        // Add search functionality here
                      },
                      child: Icon(Icons.search)),
                ],
              ),
            ),
            // Category Menu
            Container(
              height: 60.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip('សាសនា'),
                  _buildCategoryChip('ទំនៀមទំលាប់'),
                  _buildCategoryChip('ប្រជុំពិធីបុណ្យ'),
                  _buildCategoryChip('ព្យាករណ៍សាស្រ្ដ'),
                  // Add more categories here
                ],
              ),
            ),
            // Display Videos in 2 Columns
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 10, // Replace with your data length
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayVideoPage(
                            videoTitle: 'Video Title $index',
                            videoDescription: 'Description for video $index',
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 200, // Adjust width as needed
                              height: 150, // Adjust height as needed
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images.jpeg'), // Replace with your image asset
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                    12.0), // Rounded corners
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 60, // Adjust size as needed
                                  color: Colors
                                      .white, // Icon color on top of the image
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ទស្សទាយរាសីឆ្នាំទាំង12 ប្រចាំខែឧសភា ឆ្នាំ2024  $index',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.0),

            SizedBox(height: 16.0),
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
        backgroundColor: Colors.black12, // Yellow color for the chip
        labelStyle: TextStyle(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
