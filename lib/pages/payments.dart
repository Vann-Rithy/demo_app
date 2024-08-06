import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BankSelectionPage extends StatelessWidget {
  final double packagePrice;

  BankSelectionPage({required this.packagePrice});

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
        title: Text('ជ្រើសរើសគណនី', style: TextStyle(color: Colors.red)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildBankOption(context, 'ABA Bank', 'assets/banks/aba.png'),
          _buildBankOption(context, 'ACLEDA Bank', 'assets/banks/acleda.png'),
          _buildBankOption(context, 'Wing Bank', 'assets/banks/wing.png'),
        ],
      ),
    );
  }

  Widget _buildBankOption(
      BuildContext context, String bankName, String logoPath) {
    return Card(
      color: Colors.amber,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(logoPath, width: 40, height: 40),
        title: Text(bankName,
            style: TextStyle(
              fontSize: 20,
            )),
        onTap: () {
          String paymentLink = getPaymentLink(bankName, packagePrice);
          if (paymentLink.isNotEmpty) {
            _launchUrl(paymentLink);
          } else {
            // Handle the case where the payment link is empty
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid bank selection')),
            );
          }
        },
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  String getPaymentLink(String bankName, double amount) {
    const String id = "F75A965AF135";
    const String code = "441749";
    const String acc = "002661304";

    final Map<double, String> acledaLinks = {
      10000:
          'https://acledabank.com.kh/acleda?payment_data=qWY5B2SAUfIhLblxzOtfu5kBrmlB+ox54gwr/o9I7l+NFkiwN/iNyZ1syTMyAhi1P3QV8v0snD+ByIaaZ0AiSEZP902VFpb51jMWpAipHmklp7E+NKw8oXa8N+lee2BEo0/M0iPsFS1c4h2KY4QeNu5cfexCHyGCUPB0HahwuZUEHF1ebcDwx0xZeyCZDvnqG5NInntDk+DnBTDLkj6I+YYEM6d15SBZukT/GyQ83ZY=&key=khqr',
      14000:
          'https://acledabank.com.kh/acleda?payment_data=qWY5B2SAUfIhLblxzOtfu5kBrmlB+ox54gwr/o9I7l+NFkiwN/iNyZ1syTMyAhi1P3QV8v0snD+ByIaaZ0AiSEZP902VFpb51jMWpAipHmklp7E+NKw8oXa8N+lee2BEo0/M0iPsFS1c4h2KY4QeNkwP0zKlLGcGqmovLT+m8VGlQVAe9yocQtkdRKRQyiqvnGtd49lyZdM7kGkMimZGBPlWTGyWy7U3mBsRo4pcFxM=&key=khqr',
      60000:
          'https://acledabank.com.kh/acleda?payment_data=qWY5B2SAUfIhLblxzOtfu5kBrmlB+ox54gwr/o9I7l+NFkiwN/iNyZ1syTMyAhi1P3QV8v0snD+ByIaaZ0AiSEZP902VFpb51jMWpAipHmklp7E+NKw8oXa8N+lee2BEo0/M0iPsFS1c4h2KY4QeNiOH1C/jbxxCGbuIhPuFw3gXynzdw58pY5U1COl2xSApvc++a4+2dpcQDIq4WAb/f1tt+ORXFgiqMcd8sbOVHJM=&key=khqr',
    };

    switch (bankName) {
      case 'ABA':
        return 'https://link.payway.com.kh/aba?id=$id&code=$code&acc=$acc&amount=$amount&dynamic=true';
      case 'ACLEDA':
        return acledaLinks[amount] ?? ''; // Get link based on the amount
      case 'Wing':
        return 'https://link.payway.com.kh/wing?id=$id&code=$code&acc=$acc&amount=$amount&dynamic=true';
      default:
        return '';
    }
  }
}
