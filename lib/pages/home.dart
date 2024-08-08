import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/phone_number_prediction_page.dart';
import '../screens/house_prediction_page.dart';
import '../screens/vehicle_prediction_page.dart';
import '../screens/guarantee_prediction_page.dart';
import '../screens/name.dart';
import '../pages/idea/book.dart';
import '../pages/video.dart';
import '../pages/idea/podcast.dart';
import '../pages/idea/shop.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _category = 'None'; // To track the selected category
  String _selectedDate = 'Today'; // To track the selected date
  String _formContent = 'Please select a date'; // To display in the card

  void _updateCategory(String category) {
    setState(() {
      _category = category;
      _updateFormContent();
    });
  }

  void _updateDateContent(String date, String label) {
    setState(() {
      _selectedDate = date;
      _formContent = 'ការទស្សន៍ទាយសម្រាប់: $_category\n${label}';
    });
  }

  void _updateFormContent() {
    setState(() {
      _formContent = 'ការទស្សន៍ទាយសម្រាប់: $_category\n$_selectedDate';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16), // Add some spacing after the carousel
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton('សម្រាប់ខ្លួនឯង', 'សម្រាប់ខ្លួនឯង'),
                  _buildCategoryButton('សម្រាប់គ្រួសារ', 'សម្រាប់គ្រួសារ'),
                  _buildCategoryButton('សម្រាប់ជំនួញ', 'សម្រាប់ជំនួញ'),
                ],
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDateButton('Yesterday', 'ម្សិលមិញ'),
                    _buildDateButton('Today', 'ថ្ងៃនេះ'),
                    _buildDateButton('Tomorrow', 'ថ្ងៃស្អែក'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formContent,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 12),
                      _buildBulletPoint('ត្រូវប្រយ័ត្នក្នុងការសម្រេចចិត្ត។'),
                      _buildBulletPoint('ស្វែងរកការជួយពីដៃគូជំនាញ។'),
                      _buildBulletPoint(
                          'ពេលបញ្ចប់ការងារដោយកុំជឿទាំងស្រុងលើអ្នកដទៃ។'),
                      _buildBulletPoint(
                          'បង្កើនការពិភាក្សាជាមួយបងប្អូនប្រុសស្រី។'),
                      _buildBulletPoint('ការសម្រេចចិត្តគួរប្រយ័ត្ន។'),
                      _buildBulletPoint('ត្រូវប្រយ័ត្នក្នុងការសម្រេចចិត្ត។'),
                      _buildBulletPoint('ស្វែងរកការជួយពីដៃគូជំនាញ។'),
                      _buildBulletPoint(
                          'ពេលបញ្ចប់ការងារដោយកុំជឿទាំងស្រុងលើអ្នកដទៃ។'),
                      _buildBulletPoint(
                          'បង្កើនការពិភាក្សាជាមួយបងប្អូនប្រុសស្រី។'),
                      _buildBulletPoint('ការសម្រេចចិត្តគួរប្រយ័ត្ន។'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'សាសនាផ្សេងៗ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 60.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip('សាសនាព្រះពុទ្ធ'),
                  _buildCategoryChip('សាសនាកាតូលិក'),
                  _buildCategoryChip('សាសនាឥស្លាម'),
                  _buildCategoryChip('ព្យាករណ៍សាស្រ្ដ'),
                  // Add more categories here
                ],
              ),
            ),
            Center(
              child: Text(
                'កម្មវិធីផ្សេងៗ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(16.0), // Set the border radius
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 120.0, // Adjust height as needed
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                  enableInfiniteScroll: true,
                  viewportFraction:
                      1.0, // Ensure the carousel items fill the screen
                ),
                items: [
                  {'image': 'assets/bannerbook.png', 'page': bookpage()},
                  {'image': 'assets/bannerpodcast.png', 'page': podcast()},
                  {'image': 'assets/bannershop.png', 'page': shoppage()},
                  {'image': 'assets/bannervideo.png', 'page': VideoPage()},
                ].map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => item['page'] as Widget),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            item['image'] as String,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: GridView.builder(
                shrinkWrap:
                    true, // Ensures GridView only takes the necessary space
                physics:
                    NeverScrollableScrollPhysics(), // Prevents scrolling in GridView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
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
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _getGridItemText(index),
                            style: TextStyle(
                              fontSize: 14,
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
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildCategoryButton(String value, String label) {
    bool isSelected = _category == value;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Color(0xFFFFC107) : Color.fromARGB(31, 255, 255, 255),
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
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  ElevatedButton _buildDateButton(String value, String label) {
    bool isSelected = _selectedDate == value;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 36, right: 36),
        backgroundColor:
            isSelected ? Color(0xFFFFC107) : Color.fromARGB(31, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _updateDateContent(value, label);
      },
      child: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        Icon(Icons.circle, size: 8, color: Colors.black),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  IconData _getGridItemIcon(int index) {
    switch (index) {
      case 0:
        return Icons.phone;
      case 1:
        return Icons.home;
      case 2:
        return Icons.car_crash_sharp;
      case 3:
        return Icons.card_giftcard;
      case 4:
        return Icons.group;
      case 5:
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  String _getGridItemText(int index) {
    switch (index) {
      case 0:
        return 'លេខទូរសព្ទ';
      case 1:
        return 'លេខផ្ទះ';
      case 2:
        return 'ផ្លាកលេខឡាន';
      case 3:
        return 'លេខកុងធានាគា';
      case 4:
        return 'អក្សរឡាតាំង';
      case 5:
        return 'ប្រជ្រុយ';
      default:
        return 'demo';
    }
  }

  void _onGridItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhoneNumberPredictionPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HousePredictionPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehiclePredictionPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GuaranteePredictionPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NamePredictionPage()),
        );
        break;
      case 5:
        break;
      default:
        // Handle other cases or show an error
        break;
    }
  }
}

Widget _buildCategoryChip(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Chip(
      label: Text(label),
      backgroundColor: Color(0xFFFFC107), // Yellow color for the chip
      labelStyle: TextStyle(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
