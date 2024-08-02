import 'package:flutter/material.dart';

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

  void _calculatePrediction() {
    String houseNumber = _controller.text;
    int sum = 0;

    for (int i = 0; i < houseNumber.length; i++) {
      sum += int.tryParse(houseNumber[i]) ?? 0;
    }

    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.tryParse(e) ?? 0)
          .reduce((a, b) => a + b);
    }

    setState(() {
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
        return 'តំណាងអោយសម្បត្តិនិងការទទួលបានជោគជ័យលើវិស័យច្រើន';
      default:
        return 'លេខមិនត្រឹមត្រូវ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ការទស្សន៍ទាយលេខផ្ទះ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'បញ្ចូលលេខផ្ទះរបស់អ្នក៖',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
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
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculatePrediction,
              child: Text('ទស្សន៍ទាយ'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              _prediction,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (_prediction.isNotEmpty)
              Icon(
                Icons.home,
                size: 100.0,
                color: const Color.fromARGB(255, 150, 137, 0),
              ),
          ],
        ),
      ),
    );
  }
}
