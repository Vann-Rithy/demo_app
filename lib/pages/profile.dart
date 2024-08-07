import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  String _errorMessage = '';
  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');

    if (phone == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'No phone number found in preferences.';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.plexustrust.net/dashboard/get_profile.php'),
        body: json.encode({'phone': phone}),
        headers: {'Content-Type': 'application/json'},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success']) {
        setState(() {
          _isLoading = false;
          _profileData = data['profile'] ?? {};
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = data['message'] ?? 'Unknown error occurred.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${_profileData['phone'] ?? 'N/A'}'),
                      Text(
                          'Date Created: ${_profileData['created_at'] ?? 'N/A'}'),
                      // Add more profile fields here if needed
                    ],
                  ),
                ),
    );
  }
}
