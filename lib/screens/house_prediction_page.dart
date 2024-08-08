import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: HousePredictionPage(),
  ));
}

class HousePredictionPage extends StatefulWidget {
  @override
  _HousePredictionPageState createState() => _HousePredictionPageState();
}

class _HousePredictionPageState extends State<HousePredictionPage> {
  final TextEditingController _controller = TextEditingController();
  String _prediction = '';
  String _houseNumber = '';

  void _calculatePrediction() {
    String houseNumber = _controller.text;
    int sum = 0;

    // Calculate the sum of the digits
    for (int i = 0; i < houseNumber.length; i++) {
      sum += int.tryParse(houseNumber[i]) ?? 0;
    }

    // Reduce sum to a single digit
    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.tryParse(e) ?? 0)
          .reduce((a, b) => a + b);
    }

    // Set prediction text with the user input number
    setState(() {
      _houseNumber = houseNumber;
      _prediction = _getPredictionForNumber(sum);
    });
  }

  String _getPredictionForNumber(int number) {
    switch (number) {
      case 1:
        return 'តំណាងអោយភាពឯករាជ្យ និងការប្រកួតប្រជែង';
      case 2:
        return 'តំណាងអោយភាពសាមគ្គី និងការអភិវឌ្ឍសង្គម';
      case 3:
        return 'តំណាងអោយភាពច្នៃប្រឌិត និងការកើនឡើងទាំងសម្ដែងតាមបែបនានា';
      case 4:
        return 'តំណាងអោយភាពថេរជាងគេគឺល្អ ប៉ុន្តែមានកត្តាមិនល្អមួយចំនួននៅផ្នែកមួយ';
      case 5:
        return 'តំណាងអោយភាពសប្បាយរីករាយ និងកិច្ចការនៅប្លែកៗ';
      case 6:
        return 'តំណាងអោយសន្តិភាព និងស្នាមស្រលាញ់';
      case 7:
        return 'តំណាងអោយការសិក្សា និងការទូតស្តារជីវិតអារម្មណ៍';
      case 8:
        return 'តំណាងអោយសម្បត្តិ និងការទទួលបានជោគជ័យ';
      case 9:
        return 'តំណាងអោយសម្បត្តិនិងការទទួលបានជោគជ័យលើវិស័យជាច្រើន។ មានកេរ្ដិ៍ឈ្មោះល្អ មានបារមីខ្ពស់ មនកេរ្ដិ៍ឈ្មោះល្អ មានបារមីខ្ពស់ មានវត្ថុស័គ្គសិទ្ធិ តាមថែរក្សា ឃុំគ្រង មានបុណ្យវាសនាខ្ពស់។';
      default:
        return 'សូមបញ្ចូលលេខផ្ទះ';
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
        title: Text('ទស្សន៍ទាយលេខផ្ទះ', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'សូមបញ្ចូលតែលេខផ្ទះរបស់អ្នក',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'ឧទាហរណ៍៖ 99A បញ្ចូលតែលេខ 99',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'លេខផ្ទះ',
                hintText: 'បញ្ចូលលេខផ្ទះ',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculatePrediction,
              child: Text(
                'ទស្សន៍ទាយ',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC107),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            if (_prediction.isNotEmpty)
              Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'លេខផ្ទះ $_houseNumber: $_prediction',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
