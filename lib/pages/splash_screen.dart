import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 150, // Adjust the width as needed
            height: 150, // Maintain aspect ratio or set height as needed
            fit: BoxFit.contain, // Ensure the logo fits within the container
          ),
        ),
      ),
    );
  }
}
