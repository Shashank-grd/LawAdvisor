import 'package:flutter/material.dart';

class LawyerDetailScreen extends StatefulWidget {
  final snap;
  const LawyerDetailScreen({Key? key,required this.snap}) : super(key: key);

  @override
  _LawyerDetailScreenState createState() => _LawyerDetailScreenState();
}

class _LawyerDetailScreenState extends State<LawyerDetailScreen> {

  @override
  Widget build(BuildContext context) {
  return Text(widget.snap["username"],
  style: TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 50
  ),) ;
  }
}