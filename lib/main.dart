import 'package:flutter/material.dart';
import 'pages/home.dart'; // Ensure these files contain the respective widgets
import 'pages/video.dart';
import 'pages/idea.dart';
import 'pages/calendar.dart';
import 'pages/menu.dart';
import 'pages/profile.dart';

void main() {
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

  final List<Widget> _pages = [
    HomePage(),
    VideoPage(),
    IdeaPage(),
    CalendarPage(),
    MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildAppBar() : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        // Set background color here
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
            // Navigate to the profile page
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
