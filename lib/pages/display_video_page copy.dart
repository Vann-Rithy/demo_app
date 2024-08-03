import 'package:flutter/material.dart';

class DisplayVideoPage extends StatelessWidget {
  final String videoTitle;
  final String videoDescription;

  DisplayVideoPage({
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Video Details'),
        backgroundColor: Colors.yellow[700], // Yellow color for the AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Player Placeholder
          Container(
            color: Colors.grey[300], // Placeholder for video player
            height: 200.0, // Height of the video player
            child: Center(
              child: Text(
                'Video Player',
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          // Video Title and Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  videoDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Playlist of Videos
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your data length
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5.0),
                    // Wrap with Stack for overlaying icon
                    leading: Stack(
                      children: [
                        Container(
                          width: 70, // Set width for image container
                          height: 70, // Set height for image container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images.jpeg'), // Replace with your image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white, // Color of the play icon
                              size: 40, // Size of the play icon
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                        'ទស្សទាយរាសីឆ្នាំទាំង12 ប្រចាំខែឧសភា ឆ្នាំ2024 $index'),
                    onTap: () {
                      // Add functionality to play the selected video
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
