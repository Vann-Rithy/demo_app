import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pages/home.dart';
import 'pages/video.dart';
import 'pages/idea.dart';
import 'pages/calendar.dart';
import 'pages/menu.dart';
import 'pages/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFFC107),
          secondary: Color(0xFFFFC107),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          displayLarge: TextStyle(
            color: Colors.yellow,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xFFFFC107), // Custom color for AppBar
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(), // Show main screen initially
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? _timer;

  final List<Widget> _pages = [
    HomePage(),
    VideoPage(),
    IdeaPage(),
    CalendarPage(),
    MenuPage(),
  ];

  @override
  void initState() {
    super.initState();

    final QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      switch (shortcutType) {
        case 'action_home':
          _onItemTapped(0);
          break;
        case 'action_video':
          _onItemTapped(1);
          break;
        case 'action_idea':
          _onItemTapped(2);
          break;
        case 'action_calendar':
          _onItemTapped(3);
          break;
        case 'action_menu':
          _onItemTapped(4);
          break;
        default:
          _onItemTapped(0);
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_home',
        localizedTitle: 'Home',
        icon: 'icon_home',
      ),
      const ShortcutItem(
        type: 'action_video',
        localizedTitle: 'Videos',
        icon: 'icon_video',
      ),
      const ShortcutItem(
        type: 'action_idea',
        localizedTitle: 'Ideas',
        icon: 'icon_idea',
      ),
      const ShortcutItem(
        type: 'action_calendar',
        localizedTitle: 'Calendar',
        icon: 'icon_date',
      ),
      const ShortcutItem(
        type: 'action_menu',
        localizedTitle: 'Menu',
        icon: 'icon_home',
      ),
    ]);

    // Start polling for new posts
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkForNewPosts();
    });
  }

  Future<void> _checkForNewPosts() async {
    final response = await http
        .get(Uri.parse('https://api.plexustrust.net/dashboard/get_posts.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Trigger notification for each new post
        for (var post in data) {
          await _showNotification(post['title'], post['description']);
        }
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> _showNotification(String title, String description) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      description,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildAppBar() : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        child: BottomAppBar(
          color: Color(0xFFFFC107),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavIcon(Icons.home, 0),
              _buildBottomNavIcon(Icons.video_collection, 1),
              _buildBottomNavIcon(Icons.lightbulb, 2),
              _buildBottomNavIcon(Icons.calendar_today, 3),
              _buildBottomNavIcon(Icons.menu, 4),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
                'assets/profile.jpg'), // Replace with your profile image asset
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.asset('assets/logo.png', width: 45),
          ),
          SizedBox(width: 8),
          Text('ជំនឿ-ជំនួញ',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontFamily: 'Khmer OS Moul')),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            color: Colors.red,
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavIcon(IconData icon, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.red : Colors.black12,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(2.0),
      child: IconButton(
        icon: Icon(icon,
            color: _selectedIndex == index ? Colors.white : Colors.white),
        onPressed: () => _onItemTapped(index),
      ),
    );
  }
}
