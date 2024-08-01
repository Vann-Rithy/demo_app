import 'package:flutter/material.dart';

class FortuneTellingPage extends StatefulWidget {
  @override
  _FortuneTellingPageState createState() => _FortuneTellingPageState();
}

class _FortuneTellingPageState extends State<FortuneTellingPage> {
  final _controller = TextEditingController();
  String _fortune = '';

  void _getFortune() {
    setState(() {
      _fortune = _calculateNapoleonFortune(_controller.text);
    });
  }

  String _calculateNapoleonFortune(String name) {
    if (name.isEmpty) return 'Please enter your name.';

    // Convert name to uppercase and remove any non-alphabet characters
    name = name.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

    int sum = 0;
    for (int i = 0; i < name.length; i++) {
      sum += (name.codeUnitAt(i) - 64); // 'A' is 1, 'B' is 2, ..., 'Z' is 26
    }

    // Reduce sum to a single digit
    while (sum > 9) {
      sum = sum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }

    return _getFortuneText(sum);
  }

  String _getFortuneText(int number) {
    switch (number) {
      case 1:
        return 'Description for number 1'; // Update with actual description
      case 2:
        return 'Description for number 2'; // Update with actual description
      case 3:
        return 'Description for number 3'; // Update with actual description
      case 4:
        return 'Description for number 4'; // Update with actual description
      case 5:
        return 'មនុស្សជំពួកលេខ ៥\n\n'
            'លក្ខណៈសម្បត្តិ\n'
            'មាន​ទំនោរ​ចិត្ដ​ជា​អ្នក​ស្វា​ហាប់​រហ័សរហួន​ប្រកប​ដោយ ថាមពល​ ។ ​ដោយ​មាន​គំនិត​ផ្សងព្រេង​ជា​និស្ស័យ​មនុស្ស​នេះ​ស្រឡាញ់​សេរីភាព​ណាស់​ហើយ​ដើម្បី​សេរីភាព​មនុស្ស​នេះ​មិន​ញញើត​នឹង​លះបង់​អ្វីៗ​គ្រប់យ៉ាង​ ។ គ្មាន​អ្វី​ដែល​ថា​ធ្វើ​ទៅ​មិន​កើត​សម្រាប់​មនុស្ស​នេះ​ទេ​ហើយ​ការណា​ដែល​គេ​ថា មិន​អាច​ធ្វើ​បាន មនុស្ស​នេះ​ចូល​ចិត្ដ​ធ្វើ​បំ​ផុត​ ។ គឺ​ជា​មនុស្ស​ពិបាក​បំផុត​ហើយ​ ហ៊ាន​ប្រយុទ្ធ​នឹង​គ្រោះថ្នាក់​បំផុត​ដែរ​ ។ គេ​ជា​អ្នក​សុទិដ្ឋិនិយម មាន​កា​រត្រង់ ត្រាប់​ដែល​មិន​អាច​បំបែក​បាន គឺ​គុណសម្បត្ដិ​ទាំង​នេះ ហើយ​ដែល​ញ៉ាំង​ឱ្យ​គេ ពុះពារ​ឧបសគ្គ​គ្រប់បែប​យ៉ាង​បាន​ដោយ​ងាយ ។\n'
            'បុគ្គលភាព\n'
            'ហ៊ាន​អារកាត់​ដោយ​ឥត​រា​រែក គឺ​គេ​ជា​មនុស្ស​ក្នុង​ជំពូក​អ្នក​ដែល​ហ៊ាន​សំរេច កិច្ចការ ដោយមិន​សូវ​គិត​ច្រើន​ ។ គេ​ជា​អ្នក​ប្រកប​ដោយ​គំនិត​ភ្លឺស្វាង និង​ គួរឱ្យ​ទាក់ចិត្ដ​នៅ​ក្នុង​សង្គម​ ។ បើ​និយាយ​ឱ្យ​សាមញ្ញ​គឺ​ស៊ី​ដាច់​គេ​ដាច់​ឯង​តែ​ម្ដង មិត្ដ​ភក្ដិ​ក៏​ច្រើន​អ្នក​សើច​សរសើរ​ក៏​ច្រើន​ទៀត​ ។ ក៏​ប៉ុន្ដែ​ជន​ជំពូក​លេខ​៥ ក៏​ជា​មនុស្ស​មិន​ចេះ​អត់ធ្មត់ ហើយ​ឆាប់​ខឹង​ផង​តែ​គឺ​ជា​គុណវិបត្ដិ​ដែល​អាច​ឱ្យ អធ្យាស្រ័យ​បាន​ព្រោះ​មនុស្ស​នេះ​ចេះ​ធ្វើ​ឱ្យ​គេ​រាប់អាន​ណាស់ ។\n'
            'ស្នេហា និង អាពាហ៏ពិពាហ៏\n'
            'ដោយ​គេ​ជា​អ្នក​ឆ្លាតឆ្លុំ​ក្នុង​រឿង​ស្នេហា​គេ​ច្រើន​បាន​ទទួល​ជោគជ័យ​ជានិច្ច​ ។ គេ​ចូល​ចិត្ដ​រៀបការ​យ៉ាង​ហ៊ឹកហ៊ាក់​ហើយ​ការ​រស់​នៅ​ជា​មួយ​គេ​ច្រើន​តែ​បាន​ជួប ប្រទះ​នឹង​រឿង​ថ្មី​ជានិច្ច​តែ​រឿង​ថ្មី​ទាំង​នេះ​មិនមែន​សុទ្ធ​តែ​ជា​រឿង​សប្បាយ​ទេ ​។ គេ​ត្រូវ​រៀបការ​ជា​មួយ​មនុស្ស​ជំពូក​លេខ​៥​ដូចគ្នា​ហើយ​ការ​រួមរស់​របស់​គេ​ច្រើន​តែ​ជួប​នឹង​រឿង​ថ្មី ហើយ​គ្រោតគ្រាត​បន្ដិច\n'
            'ការងារ និង ទំនាក់ទំនង\n'
            'អ្វីៗ​ដែល​ធ្វើ​ឱ្យ​មនុស្ស​បាន​ទទួល​ជោគជ័យ​ភ្លាមៗ​ដូចជា​ការ​ប៉ិនប្រសប់​ការ​ឈ្លាសវៃ​និង​ការ​វាយឫក​គឺ​សុទ្ធ​តែ​លក្ខណៈ​របស់​មនុស្ស​ជំពូក​លេខ​៥​ទាំង​អស់​ ។ ក៏​ប៉ុន្ដែ ដោយ​ហេតុ​ថា​មនុស្ស​ជំពូក​នេះ​ច្រើន​ជា​អ្នក​រហេចរហាច ខ្វះ​វិន័យ​មនុស្ស​នេះ ច្រើន​ទទួល​ជោគជ័យ​ក្នុង​មុខ​របរ​ណា​ដែល​អាច​ឱ្យ​ខ្លួន​គេ​សំដែង​អំណោយ​ធម្មជាតិ​ព្រម​ទាំង​គំនិត​ផ្ដើម​របស់​គេ​បាន​ ។ គេ​ច្រើន​សង្កេត​ឃើញ​មនុស្ស​ជំពូក​លេខ​៥ ជា​សិល្បករ អ្នក​កាសែត អ្នក​និពន្ធ អ្នក​បើកបរកប៉ាល់ ជាដើម​ ។\n'
            'លុយកាក់ និង ទ្រព្យសម្បត្តិ\n'
            'ចំពោះ​រឿង​លុយកាក់ មនុស្ស​នេះ​ច្រើន​ជួប​ឧបសគ្គ​ ។ ជួន​កាល​គេ​ជា​មហាសេដ្ឋី ជួន​កាល​គេ​ក៏​ក្ររហាមដែរ​ ។ ការ​ពិត​គេ​ជា​អ្នក​ចាយ​ធំ​ហើយ​ចូល​ចិត្ដ​បំពេញ​ចំណូលចិត្ដ​របស់​ខ្លួន​គ្រប់យ៉ាង ដោយ​គ្មាន​ខ្វល់​ថា​រឿង​សប្បាយ​នោះ​នឹង​ឱ្យ​ខ្លួន​គេ​ទៅ​រួច​ឬ​ក៏​ទេ​ឡើយ​ ​មនុស្ស​ជំពូក​នេះ​ឥត​ចេះ​សន្សំ​លុយកាក់​ទាល់​តែ​សោះ​ហើយ​រឿង​រត់​ការ​ប្រឡេមប្រឡំ​ក៏​អត់​ចេះ​ដែរ​ ។';
      case 6:
        return 'Description for number 6'; // Update with actual description
      case 7:
        return 'Description for number 7'; // Update with actual description
      case 8:
        return 'មនុស្សជំពួកលេខ ៨\n\n'
            'លក្ខណៈសម្បត្តិ\n'
            'ជា​មនុស្ស​ប្រកប​ដោយ​កំលាំង​ខាង​ឆន្ទៈ​រក​មិន​បាន ហើយ​មាន​ចរិត​រឹង​ដូច​ដែក​ ។ ទុក​ចិត្ដ​ខ្លួន​ឯង​ណាស់​ហើយ​បើ​នឹង​កាន់​ការ​អ្វី​មួយ​ហើយ​គឺ​ធ្វើ​ឱ្យ​ទាល់​តែ​បាន សំរេច​ទើប​សុខ​ចិត្ដ​ ។ មិន​ចេះ​សំ​លុត​គេ​ហើយ​បើ​ជួប​ប្រទះ​នឹង​ការ​ពិបាក​អ្វី​មួយ​នៅ​ពេល​កំពុង​ចង់ សំរេច​បំណង​អ្វី​មួយ​ហើយ​មនុស្ស​នេះ​ឥត​ចេះ​រា​ថយ​ឬ​ក៏​ខក​ចិត្ដ​ទេ​គឺ​ពុះពារ​ទាល់ តែបាន​ដល់​គោល​ដៅ​ ។ ជា​ទូទៅ​គឺ​ជា​មនុស្ស​ស្អប់​ការ​ខ្ជីខ្ជា​ហើយ​ចរិត​នេះ​សោត ទៀត​តែង​នាំ​មនុស្ស​នេះ​ឱ្យ​បាន​ជួប​ជួន​ជោគជ័យ​ជួន​ធ្លាក់​ទឹក​ ។ ប៉ុន្ដែ​ទោះ​ជា​យ៉ាង​ណា​ក៏​មិន​ចេះ​រារែក​ដែរ ។\n'
            'បុគ្គលភាព\n'
            'គេ​ជា​មនុស្ស​មាន​គំនិត​ប្រយុទ្ធ​ហើយ​ស្វាហាប់​ហ៊ាន​ត​ស៊ូ​យ៉ាង​ពេញ​ទំហឹង​ដើម្បី ការពារ​ឧត្ដមគតិ​ដែល​ខ្លួន​ជឿ​ថា​ល្អ​ ។ មាន​ចិត្ដ​លោភ​លន់​ហើយ​ស្វិតស្វាញ​ ។ បើ​ចង់​សំរេច​គោល​បំណង​អ្វី​មួយ​ហើយ​មនុស្ស​លេខ​៨​សុខ​ចិត្ដ​លះ​បង់​គោល បំណង​ដទៃ​ទៀត​ចោល​សិន ដើម្បី​ធ្វើ​គោល​បំណង​នេះ​ឱ្យ​ទាល់​តែ​បាន​សំរេច​ ។ អ៊ី​ចឹង​ហើយ បាន​ជា​មាន​អ្នក​ចូល​ចិត្ដ​រាប់​អាន​គេ​ច្រើន​ណាស់ ។\n'
            'ស្នេហា និង អាពាហ៏ពិពាហ៏\n'
            'ក្នុង​រឿង​ស្នេហា​មនុស្ស​ជំពូក​លេខ​៨ ច្រើន​ប្រែប្រួល​មិន​នឹង​ហ្ន​ទេ​ ។ មាន​ម្ង៉ៃ​ថ្នាក់ថ្នម​គូគាប់​មាន​ម្ង៉ៃ​ទៀត​បែប​រៀង​គេចៗ​ហើយ​បែប​វាហី​ ។ ដោយ​ហេតុ​មនុស្ស​នេះ​មាន​ចរិត​ពិបាក​បែប​នេះ​មនុស្ស​ជំពូក​លេខ​៨ ត្រូវ​រក គូ​ស្រករ​ណា​ដែល​ចេះ​យល់​ខ្លួន​ចេះអត់​ឱន​ចំពោះ​ទឹកមុខ​ប្រែប្រួល​គ្មាន​ឈប់ឈរ របស់​ខ្លួន​ ។ ​ជាទូទៅគួរ​រៀបការ​ជា​មួយ​មនុស្ស​ជំពូក​លេខ២​ ។ ការ​ពិត​ភាព​ស្រស់​ស្រាយ និង​ចិត្ដ​សន្ដោស​របស់​មនុស្ស​លេខ​២​តែង​មាន​ជោគ ជ័យ​លើ​ភាព​ជា​អ្នក​ជិះជាន់​របស់​មនុស្ស​ជំពូក​លេខ​៨ ។\n'
            'ការងារ និង ទំនាក់ទំនង\n'
            'ដោយ​ហេតុ​មាន​និស្ស័យ​ខាង​គំនិត​បង្កើត​ច្រើន និង​ប្រកប​ដោយ​ថាមពល អស្ចារ្យ​ទៀត​នោះ​មនុស្ស​ជំពូក​លេខ​៨​ត្រូវ​វាសនា​ចារ​មក​ឱ្យ​បាន​ទទួល​ជោគជ័យ​ក្នុង​កិច្ចការ​សព្វ​សារពើ​ ។ តែ​ធ្វើ​អ្វី​ហើយ​គឺ​ធ្វើ​ដោយ​មធ្យ័ត​បំផុត​ \n'
            'លុយកាក់ និង ទ្រព្យសម្បត្តិ\n'
            'គេ​ជា​មនុស្ស​ពូកែ​ខាង​យក​លុយ​ទៅ​រកស៊ី​ណាស់​ ។ ​ទោះ​ជា​សម្បត្ដិ​ទ្រព្យ​របស់ មាន​ធំ​ឬ​តូច​ក៏​ដោយ​ឱ្យ​តែ​គេ​ប្រកប​របរ​គេ​មិន​ងាយ​ខូច​ខាត​លុយ​កាក់​ទេ​ ។ មនុស្ស​ធំៗ ជា​ច្រើន​ដែល​ស្ថិត​នៅ​ក្នុង​ជំពូក​មនុស្ស​លេខ​៨​នេះ ច្រើន​រក ទ្រព្យសម្បត្ដិ​បាន​ស្ដុកស្ដម​ណាស់ ដោយ​ចាប់​រកស៊ី​ពី​គ្មាន​មួយ​សេន​ទៅ ។';
      case 9:
        return 'Description for number 9';
      default:
        return 'No fortune found.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Napoleon Fortune Telling'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Enter your name to get your fortune:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Enter your name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getFortune,
                  child: Text('Get Fortune'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _fortune,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FortuneTellingPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}
