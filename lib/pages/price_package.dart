import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './payments.dart';

class DisplayPricePackage3Page extends StatefulWidget {
  @override
  _DisplayPricePackage3PageState createState() =>
      _DisplayPricePackage3PageState();
}

class _DisplayPricePackage3PageState extends State<DisplayPricePackage3Page> {
  String? selectedPackage;
  String? selectedPrice;
  String? selectedDisplayPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/background_app.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              // Centered logo and texts
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Image.asset('assets/logo.png',
                          width: 120, height: 120),
                    ),
                    Text(
                      'ជំនឿ - ជំនួញ ព្រីមៀម',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'ចំណុចពិសេសដែលផ្ដល់ជូន សម្រាប់កញ្ចប់ ជំនឿ និង ជំនួញ ព្រីមៀម',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Scrollable card list
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _buildPriceCard(
                        title: 'កញ្ចប់ប្រចាំសប្ដាហ៍',
                        price: '10000.0',
                        displayPrice: '១០០០០៛/១សប្ដាហ៍',
                        features: [
                          'បន្ថែមល្បឿនលឿនជាងមុន ២ដង',
                          'មិនមានការរំខានពីការផ្សាយពាណិជ្ជកម្ម',
                          'ទទួលបាន Blue Tick នៅលើ Profile'
                        ],
                        isSelected: selectedPackage == 'កញ្ចប់ប្រចាំសប្ដាហ៍',
                        onTap: () => _onCardTap('កញ្ចប់ប្រចាំសប្ដាហ៍',
                            '10000.0', '១០០០០៛/១សប្ដាហ៍'),
                      ),
                      SizedBox(height: 5),
                      _buildPriceCard(
                        title: 'កញ្ចប់ប្រចាំខែ',
                        price: '14000.0',
                        displayPrice: '១៤០០០៛/១ខែ',
                        features: [
                          'បន្ថែមល្បឿនលឿនជាងមុន ២ដង',
                          'មិនមានការរំខានពីការផ្សាយពាណិជ្ជកម្ម',
                          'ទទួលបាន Blue Tick នៅលើ Profile'
                        ],
                        isSelected: selectedPackage == 'កញ្ចប់ប្រចាំខែ',
                        onTap: () => _onCardTap(
                            'កញ្ចប់ប្រចាំខែ', '14000.0', '១៤០០០៛/១ខែ'),
                      ),
                      SizedBox(height: 5),
                      _buildPriceCard(
                        title: 'កញ្ចប់ប្រចាំឆ្នាំ',
                        price: '60000.0',
                        displayPrice: '៦០០០០៛/១ឆ្នាំ',
                        features: [
                          'បន្ថែមល្បឿនលឿនជាងមុន ២ដង',
                          'មិនមានការរំខានពីការផ្សាយពាណិជ្ជកម្ម',
                          'ទទួលបាន Blue Tick នៅលើ Profile'
                        ],
                        isSelected: selectedPackage == 'កញ្ចប់ប្រចាំឆ្នាំ',
                        onTap: () => _onCardTap(
                            'កញ្ចប់ប្រចាំឆ្នាំ', '60000.0', '៦០០០០៛/១ឆ្នាំ'),
                      ),
                    ],
                  ),
                ),
              ),
              // Subscribe Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedPackage != null) {
                      // Navigate to the bank selection page with the price
                      final selectedBank = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankSelectionPage(
                              packagePrice: double.parse(selectedPrice!)),
                        ),
                      );
                      // Handle the selected bank
                      if (selectedBank != null) {
                        print('Selected bank: $selectedBank');
                        // Implement further actions based on the selected bank
                      }
                    } else {
                      // Show a message to select a package first
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a package first'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    selectedPackage != null
                        ? 'ទិញ$selectedPackage $selectedDisplayPrice'
                        : 'ជ្រើសរើសកញ្ចប់សេវាកម្ម',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC107), // Button color
                    foregroundColor: Colors.black, // Text color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Close button
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 15),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the page
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCardTap(String package, String price, String displayPrice) {
    setState(() {
      selectedPackage = package;
      selectedPrice = price;
      selectedDisplayPrice = displayPrice;
    });
  }

  Widget _buildPriceCard({
    required String title,
    required String price,
    required String displayPrice,
    required List<String> features,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    displayPrice,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...features
                      .map((feature) => Text(
                            '- $feature',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'ចំណេញ\nSave 20%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
