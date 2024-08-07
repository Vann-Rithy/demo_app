import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'terms_and_conditions_page.dart';

class AstrologicalInfoPage extends StatefulWidget {
  @override
  _AstrologicalInfoPageState createState() => _AstrologicalInfoPageState();
}

class _AstrologicalInfoPageState extends State<AstrologicalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _latinNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _birthTimeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final String name = _nameController.text.trim();
      final String latinName = _latinNameController.text.trim();
      final String dob = _dobController.text.trim();
      final String birthTime = _birthTimeController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('https://api.plexustrust.net/dashboard/register.php'),
          body: {
            'name': name,
            'latin_name': latinName,
            'dob': dob,
            'birth_time': birthTime,
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['success']) {
            // Navigate to Terms and Conditions Page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsAndConditionsPage(),
              ),
            );
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(data['message'] ?? 'An error occurred.'),
            ));
          }
        } else {
          // Handle server error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Server error. Please try again later.'),
          ));
        }
      } catch (e) {
        // Handle unexpected error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('An unexpected error occurred. Please try again later.'),
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'ចុះឈ្មោះទស្សន៍ទាយ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 8),
            Text(
              'សូមបញ្ចូលថ្ងៃខែឆ្នាំកំណើត ដើម្បីដឹងពីជោគជាតារាសីលោកអ្នក!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextFormField(
                    controller: _nameController,
                    label: 'នាម-គោត្តនាម (ឈ្មោះពេញ)',
                    hint: 'នាម-គោត្តនាម (ឈ្មោះពេញ)',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    controller: _latinNameController,
                    label: 'ឈ្មោះជាភាសាឡាតាំង',
                    hint: 'សូមបញ្ចូលឈ្មោះជាភាសាឡាតាំង',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name in Latin';
                      }
                      return null;
                    },
                  ),
                  _buildDatePickerField(
                    controller: _dobController,
                    label: 'ថ្ងៃ-ខែ-ឆ្នាំកំណើត',
                    hint: 'Select your date of birth',
                  ),
                  _buildTimePickerField(
                    controller: _birthTimeController,
                    label: 'ម៉ោងកំណើត [បើមាន]',
                    hint: 'Select your birth time',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 200, // Adjust the button width as needed
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Color(0xFFFFC107), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 5, // Add shadow effect
                        ),
                        onPressed: _submitForm,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )
                            : Text(
                                'ទស្សន៍ទាយ',
                                style: TextStyle(
                                  color: Colors.black, // Button text color
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
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

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode()); // Hide the keyboard
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              controller.text =
                  '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
            });
          }
        },
      ),
    );
  }

  Widget _buildTimePickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode()); // Hide the keyboard
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              controller.text = pickedTime.format(context);
            });
          }
        },
      ),
    );
  }
}
