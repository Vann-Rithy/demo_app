import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isChecked = false;
  bool _isScrolledToEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position;
      setState(() {
        _isScrolledToEnd = position.pixels >= position.maxScrollExtent;
      });
    }
  }

  void _acceptTerms() {
    if (_isChecked && _isScrolledToEnd) {
      // Handle acceptance of the terms and conditions here
      Navigator.pop(context, 'Accepted');
    } else {
      // Show an alert or feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please read and accept the terms and conditions.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('លក្ខខណ្ឌនៃការប្រើប្រាស់'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'លក្ខខណ្ឌនៃការប្រើប្រាស់កម្មវិធីទូរសព្ទដៃ «ជំនឿ-ជំនួញ»',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'សូមស្វាគមន៍មកកាន់កម្មវិធីទូរសព្ទដៃ «ជំនឿ-ជំនួញ» ដែលជាកម្មវិធីផ្តល់នូវចំណេះដឹងអំពី «ជំនឿបែបវិទ្យាសាស្រ្ត»។ ជឿលើកម្មវិធី «ជំនឿ-ជំនួញ» គឺជឿប្រកបដោយបញ្ញាដែលនឹងនាំឱ្យជីវិត ការងារ គ្រួសារ និងការប្រកបមុខរបររកស៊ី ធ្វើជំនួញតូច-ធំ របស់លោកអ្នករីកចម្រើនជាលំដាប់។ កម្មវិធីទូរសព្ទដៃ «ជំនឿ-ជំនួញ» ផលិតដោយអង្គភាពសារព័ត៌មាន អេស.អ៊ឹម.អ៊ី (SME News): https://www.smenews.asia និងមានឯកឧត្តម សាស្រ្តាចារ្យបណ្ឌិត អ៊ឹម បុរិន្ទ អ្នកស្រាវជ្រាវវិទ្យាហោរាសាស្រ្តខ្មែរ ចិន សកល និងជាទីប្រឹក្សាអមគណៈកម្មាធិការ​ជាតិរៀបចំបុណ្យជាតិ និងអន្តរជាតិ ជាទីប្រឹក្សាផ្ទាល់។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('១. ការចុះឈ្មោះគណនី'),
                    Text(
                      'ការចុះឈ្មោះគណនីនៅក្នុងកម្មវិធីនេះត្រូវការតែការផ្តល់ព័ត៌មានផ្ទាល់ខ្លួនដែលត្រឹមត្រូវនិងពិតប្រាកដ។ អ្នកត្រូវតែមានអាយុចន្លោះមួយជាពីរដល់ ១៨ ឆ្នាំ ហើយអាចត្រូវបានស្នើឱ្យផ្តល់ឯកសារអត្តសញ្ញាណសម្រាប់ការបញ្ជាក់។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('២. ការជាវ'),
                    Text(
                      'ការជាវគឺជាការសន្យាផ្ទាល់នឹងការទូទាត់ជាប្រចាំសម្រាប់ការប្រើប្រាស់សេវាកម្មបន្ថែមនៃកម្មវិធី។ អ្នកអាចជាវឬបញ្ឈប់ការជាវក្នុងពេលណាមួយដោយអនុវត្តន៍តាមដែនការដែលបានកំណត់។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('៣. ការលុបចោល'),
                    Text(
                      'អ្នកអាចលុបចោលគណនីរបស់អ្នកបានតាមរយៈការទំនាក់ទំនងជាមួយក្រុមការងារបច្ចេកទេសរបស់យើង។ ការលុបចោលអាចធ្វើបានតែបន្ទាប់ពីការផ្តល់ការស្នើសុំជាលិខិតឬអ៊ីមែល និងពិនិត្យសកម្មភាព។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('៤. លក្ខខណ្ឌទូទាត់ប្រាក់'),
                    Text(
                      'ការទូទាត់ប្រាក់ត្រូវតែប្រើប្រាស់វិធីសាស្ត្រដែលបានគាំទ្រនិងត្រូវតែអនុវត្តតាមលក្ខខណ្ឌដើម្បីធានាការផ្ទេរប្រាក់ល្អឥតខ្ចោះ។ អ្នកនឹងទទួលបានការជូនដំណឹងអំពីការទូទាត់ដែលបានបញ្ចប់។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('៥. សិទ្ធិនៃការលុបចោល'),
                    Text(
                      'អ្នកមានសិទ្ធិដើម្បីលុបចោលព័ត៌មានបច្ចុប្បន្ននៃគណនីរបស់អ្នកនឹងត្រូវតែតាមដានការយកសមរម្យការលុបចោល។ ការលុបចោលព័ត៌មានមិនអាចត្រូវបានអ៊ែតត្រឡប់មកវិញ។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle(
                        '៦. សិទ្ធិអ្នកនិពន្ធ / សិទ្ធិនៃការប្រើប្រាស់'),
                    Text(
                      'ទិន្នន័យទាំងអស់និងមាតិកាដែលត្រូវបានបង្កើតដោយកម្មវិធីជាសកម្មភាពមានសិទ្ធិទាំងអស់ទទួលបានដោយមិនប៉ះពាល់ដល់សិទ្ធិរបស់អ្នកប្រើប្រាស់។ អ្នកមិនអាចចម្លង ឬការផ្សាយពាណិជ្ជកម្មជាមួយនឹងមាតិកានេះដោយមិនទទួលការអនុញ្ញាតពីអ្នកនិពន្ធទេ។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('៧. ការធានា / សំណងការខូចខាត'),
                    Text(
                      'កម្មវិធីនេះត្រូវបានផ្តល់ជូនជាលក្ខណៈ «ដែលមាន» និងមិនមានការធានានូវលទ្ធផល ឬភាពជោគជ័យណាមួយទេ។ មិនត្រូវជឿការធានាថាកម្មវិធីនេះអាចស្ដារឡើងវិញបន្ទាប់ពីករណីខូចខាតឬបាត់បង់ទេ។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildSectionTitle('៨. គោលការណ៍ឯកជនភាព'),
                    Text(
                      'គោលការណ៍ឯកជនភាពបញ្ជាក់ពីរបៀបដែលយើងប្រមូល ការប្រើប្រាស់ និងការពារព័ត៌មានផ្ទាល់ខ្លួនរបស់អ្នក។ យើងធានាថាព័ត៌មានរបស់អ្នកត្រូវបានរក្សាទុកក្នុងសន្តិសុខ និងត្រូវបានប្រើប្រាស់តាមការអនុញ្ញាតច្បាស់លាស់របស់អ្នក។',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'ខ្ញុំយល់ព្រមជាមួយលក្ខខណ្ឌនៃការប្រើប្រាស់',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed:
                      _isChecked && _isScrolledToEnd ? _acceptTerms : null,
                  child: Text('ទទួលយក'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
