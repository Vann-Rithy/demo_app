import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DisplayVideoPage extends StatefulWidget {
  final Map<String, dynamic> video;

  DisplayVideoPage({required this.video});

  @override
  _DisplayVideoPageState createState() => _DisplayVideoPageState();
}

class _DisplayVideoPageState extends State<DisplayVideoPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _isControlsVisible = true;
  bool _isFullScreen = false;
  double _volume = 1.0;
  double _playbackSpeed = 1.0;
  late Future<List<Map<String, dynamic>>> _relatedVideosFuture;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://api.plexustrust.net/dashboard/${widget.video['video_path']}'),
    )..initialize().then((_) {
        setState(() {}); // Refresh UI when the video is initialized
      });

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _relatedVideosFuture = _fetchVideos(); // Initialize the fetch
  }

  @override
  void dispose() {
    _videoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _fetchVideos() async {
    final response = await http
        .get(Uri.parse('https://api.plexustrust.net/dashboard/get_videos.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  void _toggleControlsVisibility() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
      if (_isControlsVisible) {
        _fadeController.forward();
      } else {
        _fadeController.reverse();
      }
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video['title'] ?? 'Video Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: GestureDetector(
              onTap: _toggleControlsVisibility,
              child: Stack(
                children: [
                  _videoController.value.isInitialized
                      ? VideoPlayer(_videoController)
                      : Center(child: CircularProgressIndicator()),
                  if (_isControlsVisible)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Top Controls
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (_isFullScreen)
                                    IconButton(
                                      icon: Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: _toggleFullScreen,
                                    ),
                                ],
                              ),
                            ),
                            // Bottom Controls
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Play/Pause Button
                                  IconButton(
                                    icon: Icon(
                                      _videoController.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_videoController.value.isPlaying) {
                                          _videoController.pause();
                                        } else {
                                          _videoController.play();
                                        }
                                      });
                                    },
                                  ),
                                  // Volume Control
                                  IconButton(
                                    icon: Icon(
                                      _volume > 0
                                          ? Icons.volume_up
                                          : Icons.volume_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _volume = _volume > 0 ? 0 : 1.0;
                                        _videoController.setVolume(_volume);
                                      });
                                    },
                                  ),
                                  // Playback Speed Control
                                  PopupMenuButton<double>(
                                    icon:
                                        Icon(Icons.speed, color: Colors.white),
                                    onSelected: (speed) {
                                      setState(() {
                                        _playbackSpeed = speed;
                                        _videoController
                                            .setPlaybackSpeed(_playbackSpeed);
                                      });
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 0.5, child: Text('0.5x')),
                                      PopupMenuItem(
                                          value: 1.0, child: Text('1.0x')),
                                      PopupMenuItem(
                                          value: 1.5, child: Text('1.5x')),
                                      PopupMenuItem(
                                          value: 2.0, child: Text('2.0x')),
                                    ],
                                  ),
                                  // Full-Screen Toggle
                                  IconButton(
                                    icon: Icon(
                                      _isFullScreen
                                          ? Icons.fullscreen_exit
                                          : Icons.fullscreen,
                                      color: Colors.white,
                                    ),
                                    onPressed: _toggleFullScreen,
                                  ),
                                  // Progress Indicator
                                  Expanded(
                                    child: VideoProgressIndicator(
                                      _videoController,
                                      allowScrubbing: true,
                                      colors: VideoProgressColors(
                                        playedColor: Colors.blue,
                                        bufferedColor: Colors.grey,
                                        backgroundColor: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.video['title'] ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.video['description'] ?? 'No Description',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _relatedVideosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Related Videos'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final video = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayVideoPage(
                                video: video,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://api.plexustrust.net/dashboard/${video['thumbnail_path']}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 48.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    video['title'] ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
