import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryCard extends StatefulWidget {
  final snap;

  const BookingHistoryCard({Key? key, required this.snap}) : super(key: key);

  @override
  _BookingHistoryCard createState() => _BookingHistoryCard();
}

class _BookingHistoryCard extends State<BookingHistoryCard> {
  final dateFormatter = DateFormat('dd-MM-yyyy'); // Customize as needed
  final timeFormatter = DateFormat('HH:mm:ss');

  String mobile="";
  String  email="";
  String  address="";
  @override
  void initState() {
    super.initState();
    getLawyername();
  }

  void getLawyername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Lawyers')
        .doc(widget.snap['lawyerId'])
        .get();
    print(snap.data());
    setState(() {
     mobile=(snap.data() as Map<String,dynamic>)['mobile'];
     email=(snap.data() as Map<String,dynamic>)['email'];
     address=(snap.data() as Map<String,dynamic>)['address'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking ID: ${widget.snap['BookingId']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Lawyer Name: ${widget.snap['lawyerName']}',
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              'Lawyer Mobile No.: ${mobile}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Lawyer Email: ${email}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Lawyer Address: ${address}',
              style: const TextStyle(fontSize: 16),
            ), Text(
              'Date: ${dateFormatter.format(widget.snap['datePublished'].toDate())}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${timeFormatter.format(widget.snap['datePublished'].toDate())}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}