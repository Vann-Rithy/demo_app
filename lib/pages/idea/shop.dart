import 'package:flutter/material.dart';

class shoppage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/icons_back.png',
            width: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('គ្រឿងបរិក្ខា', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/backgrounds/background_app.png'), // Replace with your background image
            fit: BoxFit.cover, // Adjust how the image fits in the container
          ),
        ),
        child: Center(
          child: Text(
            'គ្រឿងបរិក្ខា',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
