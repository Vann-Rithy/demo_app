import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhoneNumberPredictionPage extends StatelessWidget {
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
        title: Text('ការទស្សន៍ទាយលេខទូរស័ព្ទ',
            style: TextStyle(color: Colors.red)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PhoneNumberCheckPage(),
    );
  }
}

class PhoneNumberCheckPage extends StatefulWidget {
  @override
  _PhoneNumberCheckPageState createState() => _PhoneNumberCheckPageState();
}

class _PhoneNumberCheckPageState extends State<PhoneNumberCheckPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneNumberController = TextEditingController();
  String _prediction = '';
  String _details = '';
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  // Function to validate phone number format
  bool _validatePhoneNumber(String phoneNumber) {
    final regExp = RegExp(r'^0[1-9][0-9]{8}$'); // Adjust regex as needed
    return regExp.hasMatch(phoneNumber);
  }

  // Function to check phone number
  Future<void> _checkPhoneNumber() async {
    final phoneNumber = _phoneNumberController.text.trim();

    if (!_validatePhoneNumber(phoneNumber)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('លេខទូរសព្ទមិនត្រឹមត្រូវ'),
            content:
                Text('សូមបញ្ចូលលេខទូរស័ព្ទដែលត្រឹមត្រូវសម្រាប់ការទស្សន៍ទាយ'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('យល់ព្រម'),
              ),
            ],
          );
        },
      );
      return;
    }

    final response = await http.post(
      Uri.parse('https://api.plexustrust.net/check_phone.php'),
      body: {'phone_number': phoneNumber},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _prediction =
            responseData['prediction'] ?? 'មានបញ្ហាក្នុងការពិនិត្យលេខទូរស័ព្ទ';
        _details = responseData['details'] ?? '';
        _animationController.forward(from: 0.0);
      });
    } else {
      setState(() {
        _prediction = 'មានបញ្ហាក្នុងការពិនិត្យលេខទូរស័ព្ទ';
        _details = '';
        _animationController.reverse(from: 1.0);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Column(
                    children: [
                      Text(
                        'សូមបញ្ចូលលេខទូរស័ព្ទរបស់អ្នក',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'ឧទាហរណ៍៖ 010 8855 547',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 12),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      labelText: 'លេខទូរស័ព្ទ',
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkPhoneNumber,
                    child: Text(
                      'ទស្សន៍ទាយ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                          0xFFFFC107), // Updated property for background color
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _animation,
                    child: ScaleTransition(
                      scale: _animation,
                      child: _prediction.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    _prediction,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (_details.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        _details,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent[700],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
