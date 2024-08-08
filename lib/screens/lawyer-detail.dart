import 'package:flutter/cupertino.dart';
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
  return Scaffold(
    appBar:AppBar(
      title: Image.asset('assets/appbarlawadv.png'
        ,height: 180,
        width: 200,
      ),
    ),
    body: Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:  NetworkImage(
                    widget.snap["photoUrl"]
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap["username"],
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            color: Colors.grey
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 6,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.snap['age'].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 6,
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.snap["gender"],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 6,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.snap["city"],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 6,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.snap["court"],
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              widget.snap["speci"],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade50.withOpacity(0.05),
                          ),

                          SizedBox(width: 10),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 6,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${widget.snap["experience"].toString()} yrs +',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black12,

            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("License No. :",
              style: TextStyle(
                fontSize: 22
              ),
              ),
              Text(widget.snap['license'],
                style: TextStyle(
                    fontSize: 22
                ),
              )
            ],
          ),
        ),

        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'About :',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.snap['about'],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SizedBox(
            width: double.infinity, // Ensures the button takes up the full width
            height: 50, // Set a fixed height for the button
            child: ElevatedButton(
              onPressed: () {
                // Define what happens when the button is pressed
                // For example, navigate to a booking page or trigger a booking process
              },
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white,// Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ) ;
  }
}