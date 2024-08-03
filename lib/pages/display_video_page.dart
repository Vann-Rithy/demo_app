import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'related_video_page.dart';

class DisplayVideoPage extends StatefulWidget {
  final Map<String, dynamic> video;
  final List<Map<String, dynamic>> relatedVideos; // List of related videos

  DisplayVideoPage({
    required this.video,
    this.relatedVideos = const [], // Default to an empty list if not provided
  });

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

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://api.plexustrust.net/dashboard/${widget.video['video_path']}',
    )..initialize().then((_) {
        setState(() {}); // Refresh UI when the video is initialized
      });

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _fadeController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Column(
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
                                          if (_videoController
                                              .value.isPlaying) {
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
                                      icon: Icon(Icons.speed,
                                          color: Colors.white),
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
            Text(
              widget.video['title'] ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.video['description'] ?? 'No Description',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Related Videos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.relatedVideos.length,
              itemBuilder: (context, index) {
                final relatedVideo = widget.relatedVideos[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Image.network(
                      'https://api.plexustrust.net/dashboard/${relatedVideo['thumbnail_path']}',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(relatedVideo['title'] ?? 'No Title'),
                    subtitle:
                        Text(relatedVideo['description'] ?? 'No Description'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RelatedVideoPage(
                            video: relatedVideo,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
