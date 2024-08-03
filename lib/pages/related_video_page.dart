import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RelatedVideoPage extends StatefulWidget {
  final Map<String, dynamic> video;

  RelatedVideoPage({required this.video});

  @override
  _RelatedVideoPageState createState() => _RelatedVideoPageState();
}

class _RelatedVideoPageState extends State<RelatedVideoPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://api.plexustrust.net/dashboard/${widget.video['video_path']}',
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video['title'] ?? 'Video Details'),
      ),
      body: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
