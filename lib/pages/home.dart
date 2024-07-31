import 'package:flutter/material.dart';
import '../screens/phone_number_prediction_page.dart';
import '../screens/house_prediction_page.dart';
import '../screens/vehicle_prediction_page.dart';
import '../screens/guarantee_prediction_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _category = 'None'; // To track the selected category
  String _dateContent = 'Please select a date'; // To track the selected date
  String _formContent = 'Please select a date'; // To display in the card

  void _updateCategory(String category) {
    setState(() {
      _category = category;
      _updateFormContent();
    });
  }

  void _updateDateContent(String content) {
    setState(() {
      _dateContent = content;
      _updateFormContent();
    });
  }

  void _updateFormContent() {
    setState(() {
      _formContent = 'ការទស្សន៍ទាយសម្រាប់: $_category\n $_dateContent';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row containing the category buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('សម្រាប់ខ្លួនឯង', 'សម្រាប់ខ្លួនឯង'),
                  _buildCategoryButton('គ្រួសារ', 'គ្រួសារ'),
                  _buildCategoryButton('ជំនួញ', 'ជំនួញ'),
                ],
              ),
            ),
            // Row containing the date buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDateButton('Yesterday', 'ម្សិលមិញ'),
                  _buildDateButton('Today', 'ថ្ងៃនេះ'),
                  _buildDateButton('Tomorrow', 'ថ្ងៃស្អែក'),
                ],
              ),
            ),
            // Display the dynamic form content
            Card(
              color: Color(0xFFFFC107),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    _formContent,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // GridView for other items
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap:
                  true, // Ensures GridView only takes the necessary space
              physics:
                  NeverScrollableScrollPhysics(), // Prevents scrolling in GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: Color(0xFFFFC107),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      _onGridItemTap(context, index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getGridItemIcon(index),
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Text(
                          _getGridItemText(index),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildCategoryButton(String value, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _category == value ? Colors.blueAccent : Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _updateCategory(value);
      },
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  ElevatedButton _buildDateButton(String value, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _dateContent.contains(value) ? Color(0xD4D4D4) : Color(0xFFFFC107),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _updateDateContent(
            'ចំពោះ $label\n ត្រូវប្រយ័ត្នក្នុងការសម្រេចចិត្ត។ ស្វែងរកការជួយពីដៃគូជំនាញ។ ពេលបញ្ចប់ការងារដោយកុំជឿទាំងស្រុងលើអ្នកដទៃ។ បង្កើនការពិភាក្សាជាមួយបងប្អូនប្រុសស្រី។ ការសម្រេចចិត្តគួរប្រយ័ត្ន។');
      },
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _onGridItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhoneNumberPredictionPage()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HousePredictionPage()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VehiclePredictionPage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GuaranteePredictionPage()));
        break;
    }
  }

  String _getGridItemText(int index) {
    switch (index) {
      case 0:
        return 'លេខទូរសព្ទ';
      case 1:
        return 'លេខផ្ទះ';
      case 2:
        return 'លេខយានយន្ដ';
      case 3:
        return 'លេខកុងធានាគា';
      default:
        return '';
    }
  }

  IconData _getGridItemIcon(int index) {
    switch (index) {
      case 0:
        return Icons.phone;
      case 1:
        return Icons.home;
      case 2:
        return Icons.directions_car;
      case 3:
        return Icons.card_giftcard;
      default:
        return Icons.help;
    }
  }
}
