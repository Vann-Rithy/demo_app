import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            Color.fromARGB(255, 199, 149, 0), // Background color set to yellow
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
                    color:
                        Colors.black, // Text color adjusted for better contrast
                  ),
                ),
                SizedBox(height: 30),
                _buildMenuOption(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    // Navigate to Home Page
                  },
                ),
                _buildMenuOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Navigate to Settings Page
                  },
                ),
                _buildMenuOption(
                  icon: Icons.help,
                  title: 'Help',
                  onTap: () {
                    // Show Help Dialog
                  },
                ),
                _buildMenuOption(
                  icon: Icons.info,
                  title: 'About',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
              0.8), // Slightly opaque to stand out against the yellow background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: Colors.black), // Icon color adjusted for better contrast
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // Text color adjusted for better contrast
              ),
            ),
          ],
        ),
      ),
    );
  }
}
