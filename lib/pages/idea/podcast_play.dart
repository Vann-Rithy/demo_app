// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class DetailPage extends StatefulWidget {
//   final String podcastPath;

//   DetailPage({required this.podcastPath});

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       setState(() {
//         _isPlaying = state == PlayerState.PLAYING;
//       });
//     });

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _duration = duration;
//       });
//     });

//     _audioPlayer.onAudioPositionChanged.listen((Duration position) {
//       setState(() {
//         _position = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _playPause() async {
//     if (_isPlaying) {
//       await _audioPlayer.pause();
//     } else {
//       await _audioPlayer.play(widget.podcastPath);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Podcast Player'),
//         backgroundColor: Colors.red,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Icon(
//                 _isPlaying ? Icons.pause : Icons.play_arrow,
//                 size: 100.0,
//                 color: Colors.red,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Duration: ${_formatDuration(_duration)}',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             Text(
//               'Position: ${_formatDuration(_position)}',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _playPause,
//               child: Text(_isPlaying ? 'Pause' : 'Play'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }
