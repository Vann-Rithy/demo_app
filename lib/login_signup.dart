import 'package:flutter/material.dart';
import 'login_page.dart';

class LoginSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/backgrounds/background_app.png', // Path to your background image
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ជំនឿ-ជំនួញ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Khmer OS Moul',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('ចូលប្រើប្រាស់'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC107), // Background color
                      foregroundColor: Colors.black, // Text color
                      minimumSize:
                          Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the signup page
                    },
                    child: Text('ចុះឈ្មោះប្រើប្រាស់'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFC107), // Background color
                      foregroundColor: Colors.black, // Text color
                      minimumSize:
                          Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
