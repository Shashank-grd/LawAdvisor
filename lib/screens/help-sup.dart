import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String name = "SHASHANK KUMAR SINHA";
    final String mes = "Please feel free to Contact Us for any kind of help, you may Contact Us on the details given below :";
    final String phoneNumber = "+91 9507373835";
    final String email = "shashank.2grd@gmail.com";
    final String office = "jaypee college";

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/appbarlawadv.png',
          height: 180,
          width: 200,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mes,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.white.withOpacity(0.2), // 30% opacity
              thickness: 1,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ContactDetailItem(
              icon: Icons.phone,
              detail: phoneNumber,
            ),
            SizedBox(height: 10),
            ContactDetailItem(
              icon: Icons.email,
              detail: email,
            ),
            SizedBox(height: 10),
            ContactDetailItem(
              icon: Icons.location_on,
              detail: office,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetailItem extends StatelessWidget {
  final IconData icon;
  final String detail;

  const ContactDetailItem({
    Key? key,
    required this.icon,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.blue,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactDetailsScreen(),
  ));
}
