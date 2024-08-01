import 'package:flutter/material.dart';
import './idea/shop.dart';
import './idea/book.dart';
import './idea/podcast.dart';
import './idea/read.dart';

class IdeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'ចំណេះដឹង',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Color for the title
                ),
              ),
            ),
            // Grid of items
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap:
                    true, // Allows the GridView to be within SingleChildScrollView
                physics:
                    NeverScrollableScrollPhysics(), // Prevent scrolling within the GridView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 2.0, // Space between columns
                  mainAxisSpacing: 2.0, // Space between rows
                  childAspectRatio: 1.2, // Aspect ratio of each child
                ),
                itemCount: 6, // Number of items in the grid
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
                            size: 30,
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
            ),
          ],
        ),
      ),
    );
  }

  void _onGridItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => readpage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => podcast()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bookpage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => shoppage()));
        break;
    }
  }

  String _getGridItemText(int index) {
    switch (index) {
      case 0:
        return 'អានអត្ថបទ';
      case 1:
        return 'ស្ដាប់ Podcast';
      case 2:
        return 'បណ្ដុំឯកសារ';
      case 3:
        return 'គ្រឿងបរិក្ខារ';
      default:
        return '';
    }
  }

  IconData _getGridItemIcon(int index) {
    switch (index) {
      case 0:
        return Icons.library_books;
      case 1:
        return Icons.podcasts;
      case 2:
        return Icons.menu_book_sharp;
      case 3:
        return Icons.shopify_outlined;
      default:
        return Icons.help;
    }
  }
}
