// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class MusicPlayer extends StatefulWidget {
//   @override
//   _MusicPlayerState createState() => _MusicPlayerState();
// }

// class _MusicPlayerState extends State<MusicPlayer> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer.onDurationChanged.listen((duration) {
//       setState(() {
//         _duration = duration;
//       });
//     });
//     _audioPlayer.onAudioPositionChanged.listen((position) {
//       setState(() {
//         _position = position;
//       });
//     });
//   }

//   void _playPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play(
//           'https://api.plexustrust.net/dashboard/uploads/podcasts/Free%20Background%20Music%20For%20Youtube%20Videos%20No%20Copyright%20Download%20for%20Content%20Creators.mp3');
//     }
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Music Player'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Cover image
//           Container(
//             height: 200,
//             width: 200,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: AssetImage('assets/images.jpeg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           // Track title
//           Text(
//             'Background Music',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Text(
//             'No Copyright Music for YouTube Videos',
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),
//           SizedBox(height: 30),
//           // Progress bar
//           Slider(
//             value: _position.inSeconds.toDouble(),
//             min: 0,
//             max: _duration.inSeconds.toDouble(),
//             onChanged: (value) {
//               setState(() {
//                 _audioPlayer.seek(Duration(seconds: value.toInt()));
//               });
//             },
//           ),
//           // Play/Pause button
//           IconButton(
//             icon: Icon(
//               _isPlaying ? Icons.pause : Icons.play_arrow,
//               size: 64,
//               color: Colors.blueAccent,
//             ),
//             onPressed: _playPause,
//           ),
//         ],
//       ),
//     );
//   }
// }
