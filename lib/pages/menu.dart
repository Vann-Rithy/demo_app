import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'price_package.dart';
import 'terms_and_conditions_page.dart';
import '../login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background_app.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'វ៉ាន់ រិទ្ធី',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayPricePackage3Page(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.star_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('ភ្ជាប់សេវាកម្ម'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFFFC107), // Set button background color
                    foregroundColor: Colors.black, // Text color on the button
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildMenuOption(
                  icon: Icons.account_circle,
                  title: 'គណនី',
                  onTap: () {
                    // Navigate to Home Page
                  },
                ),
                _buildMenuOption(
                  icon: Icons.settings,
                  title: 'ការកំណត់',
                  onTap: () {
                    // Navigate to Settings Page
                  },
                ),
                _buildMenuOption(
                  icon: Icons.payment,
                  title: 'ការទូទាត់',
                  onTap: () {
                    // Show Help Dialog
                  },
                ),
                _buildMenuOption(
                  icon: Icons.contact_page,
                  title: 'ទំនាក់ទំនង',
                  onTap: () {
                    _showContactDialog(context);
                  },
                ),
                _buildMenuOption(
                  icon: Icons.info,
                  title: 'អំពីកម្មវិធី',
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset(
                        'assets/logo.png',
                        width: 50,
                        height: 50,
                      ),
                      applicationName: 'កម្មវិធីទូរសព្ទដៃ «ជំនឿ-ជំនួញ»',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2024 BizApp',
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'ជា Mobile App ផ្តល់នូវចំណេះដឹងអំពី«ជំនឿបែបវិទ្យាសាស្រ្ត» ពីឯកឧត្តម សាស្រ្តាចារ្យបណ្ឌិត អ៊ឹម បុរិន្ទ អ្នកស្រាវជ្រាវវិទ្យាហោរាសាស្រ្តខ្មែរ ចិន សកល និងជាទីប្រឹក្សាអមគណៈកម្មាធិការជាតិរៀបចំបុណ្យជាតិនិងអន្តរជាតិ។ ឯកឧត្តម សាស្រ្តាចារ្យបណ្ឌិត ក៏មានទទួលមើលវេលាឫក្សពារក្នុងការប្រារព្ធពិធីមង្គលផ្សេងៗ មានអាពាហ៍ពិពាហ៍ ពិធីឡើងផ្ទះថ្មី បើកហាងថ្មី រៀបចំហុង-ស៊ុយ ហាងថ្មី មើលគ្រោះ ជោគជតាល្អអាក្រក់ កែឆុងច្រើនសេរីសួស្តី។ មើលផ្ទះសម្បែង រៀបចំគ្រឿង សក្ការៈ ជីដូនជីតា-កុងម៉ា មើលហ៊ុង-ស៊ុយ ផ្ទះសម្បែង ជ្រើសរើសវេលាកំណើត ឱ្យបុត្រាបុត្រី កំណត់ការបដិសន្ធិឱ្យកំណើត បានកូនប្រុសស្រីតាមបំណងប្រាថ្នា តាមតម្រាចិនសែ និងតម្រាបុរាណខ្មែរ ដ៏ស័ក្ដិសិទ្ធិ៕ ជឿលើកម្មវិធី«ជំនឿ-ជំនួញ» គឺជឿប្រកបដោយបញ្ញាដែលនឹងនាំឱ្យជីវិតការងារ គ្រួសារ និងការប្រកបមុខរបររកស៊ី ធ្វើជំនួញតូច-ធំរបស់លោកអ្នករីកចម្រើនជាលំដាប់៕',
                        ),
                      ],
                    );
                  },
                ),
                _buildMenuOption(
                  icon: Icons.security,
                  title: 'លក្ខខណ្ឌ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditionsPage()),
                    );
                  },
                ),
                _buildMenuOption(
                  icon: Icons.logout,
                  title: 'ចាកចេញ',
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                SizedBox(height: 20),
                Text('Powered By SME News | v1.1.0'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ទំនាក់ទំនង',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'អ្នកអាចទំនាក់ទំនងយើងតាមបណ្តាញសង្គមនិងលេខទូរសព្ទដូចខាងក្រោម៖',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () =>
                      _launchUrl('https://smenews-media-link.vercel.app/'),
                  child: Container(
                    color: Colors.grey[200], // Background color for each row
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.web, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'បណ្ដាញសង្គមផ្លូវការ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => _launchUrl('https://t.me/cheavsamnang'),
                  child: Container(
                    color: Colors.grey[200], // Background color for each row
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.telegram, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Telegram',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => _launchUrl('tel:+855968522285'),
                  child: Container(
                    color: Colors.grey[200], // Background color for each row
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '+855 96 852 2285',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchUrl('tel:+85595727470'),
                  child: Container(
                    color: Colors.grey[200], // Background color for each row
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '+855 95 727 470',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('បិទ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ចាកចេញ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            'តើអ្នកចង់ចាកចេញពីគណនីនេះទេ?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('បោះបង់'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ចាកចេញ'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
