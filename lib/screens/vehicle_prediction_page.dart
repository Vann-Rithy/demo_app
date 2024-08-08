import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: VehiclePredictionPage(),
  ));
}

class VehiclePredictionPage extends StatefulWidget {
  @override
  _VehiclePredictionPageState createState() => _VehiclePredictionPageState();
}

class _VehiclePredictionPageState extends State<VehiclePredictionPage> {
  final TextEditingController _controller = TextEditingController();
  String _prediction = '';

  // Method to show a dialog with a message
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('សារ'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('អាក្រក់'),
            ),
          ],
        );
      },
    );
  }

  // Method to calculate prediction based on plate number
  String _getPredictionForPlate(String plateNumber) {
    if (plateNumber.length < 3) {
      return 'ស្លាកលេខយានយន្ដមិនត្រឹមត្រូវ។ សូមបញ្ចូលលេខយ៉ាងតិច 3 តួអក្សរ។';
    }

    // Remove non-digit characters and sum the digits
    int sum = plateNumber
        .replaceAll(RegExp(r'[^0-9]'), '') // Remove non-digit characters
        .split('')
        .map((e) => int.tryParse(e) ?? 0)
        .reduce((a, b) => a + b);

    // Reduce to a single digit
    while (sum > 9) {
      sum = sum
          .toString()
          .split('')
          .map((e) => int.tryParse(e) ?? 0)
          .reduce((a, b) => a + b);
    }

    return _getPredictionForNumber(sum);
  }

  // Method to get prediction text based on the number
  String _getPredictionForNumber(int number) {
    switch (number) {
      case 1:
        return 'ល្អណាស់! ប្រសិនបើអ្នកឈរលើចំណុចនេះ នឹងឈានទៅកាន់ការប្រកួតប្រជែង!';
      case 2:
        return 'ល្អ! មានភាពស៊ប់សាករនិងការអភិវឌ្ឍសង្គម។';
      case 3:
        return 'ល្អ! ការច្នៃប្រឌិតនឹងផ្តល់ឱ្យអ្នកនូវកំណត់ចំណាំថ្មីៗ។';
      case 4:
        return 'មធ្យម! អ្នកអាចជួបប្រទៈការលំបាកខ្លះតែវាត្រូវបានបញ្ជាក់។';
      case 5:
        return 'ល្អ! មានភាពសប្បាយ និងការផ្លាស់ប្តូរពិសេស។';
      case 6:
        return 'ល្អណាស់! ការសម្រេចចិត្តនឹងអនុវត្តនៅក្នុងបរិយាកាសសុខសប្បាយ។';
      case 7:
        return 'ល្អ! ការសិក្សានិងការសម្រេចចិត្តអាចឆ្លៀតបាន។';
      case 8:
        return 'ល្អ! មានសម្បត្តិនិងការទទួលបានជោគជ័យ។';
      case 9:
        return 'ល្អ! សម្ថតភាពល្អនឹងនាំឱ្យមានភាពជោគជ័យក្នុងវិស័យច្រើន។';
      default:
        return 'សូមបញ្ចូលស្លាកលេខឡានដែលត្រឹមត្រូវ! ឧទាហរណ៍: 1234';
    }
  }

  void _calculatePrediction() {
    String plateNumber = _controller.text;

    if (plateNumber.isEmpty) {
      _showDialog('សូមបញ្ចូលស្លាកលេខរបស់យានយន្ដ');
    } else if (plateNumber.length < 3) {
      _showDialog(
          'ស្លាកលេខយានយន្ដមិនត្រឹមត្រូវ។ សូមបញ្ចូលលេខយ៉ាងតិច 3 តួអក្សរ។');
    } else if (plateNumber.length > 4) {
      _showDialog(
          'ស្លាកលេខយានយន្ដមិនត្រឹមត្រូវ។ សូមបញ្ចូលលេខទាំងអស់ប៉ុន្មានតួអក្សរ 3 ឬ 4 តួអក្សរ។');
    } else {
      setState(() {
        _prediction = _getPredictionForPlate(plateNumber);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ការទស្សនទាយស្លាកលេខឡាន'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ស្លាកលេខឡាន',
                hintText: 'បញ្ចូលស្លាកលេខឡាន',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Only allow digits
                LengthLimitingTextInputFormatter(4), // Limit input to 4 digits
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculatePrediction,
              child: Text(
                'ទស្សនទាយ',
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
                  child: Text(
                    _prediction,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
