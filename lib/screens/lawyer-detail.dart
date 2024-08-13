import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/lawyer-auth.dart';
import 'package:lawadvisor/Mob_nav.dart';
import 'package:lawadvisor/utils/utils.dart';


class LawyerDetailScreen extends StatefulWidget {
  final snap;
  const LawyerDetailScreen({Key? key,required this.snap}) : super(key: key);

  @override
  _LawyerDetailScreenState createState() => _LawyerDetailScreenState();
}

class _LawyerDetailScreenState extends State<LawyerDetailScreen> {
  String username="";
  String uid="";
   bool _islooding = false;

  @override
  void initState() {
    super.initState();
    getUsername();
  }


   void getUsername() async {
     DocumentSnapshot snap = await FirebaseFirestore.instance
         .collection('users')
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .get();
     print(snap.data());
     setState(() {
       username=(snap.data() as Map<String,dynamic>)['username'];
      uid=(snap.data() as Map<String,dynamic>)['uid'];
     });
   }

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:  NetworkImage(
                      widget.snap["photoUrl"]
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["username"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
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
                            SizedBox(width: 6),
                            Text(
                              widget.snap['age'].toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[500],
                              size: 6,
                            ),
                            SizedBox(width: 6),
                            Text(
                              widget.snap["gender"],
                              style: TextStyle(
                                fontSize: 15,
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
                            SizedBox(width: 6),
                            Text(
                              widget.snap["city"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.circle,
                              color: Colors.grey[500],
                              size: 6,
                            ),
                            SizedBox(width: 6),
                            Text(
                              widget.snap["court"],
                              style: TextStyle(
                                fontSize: 15,
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
                            SizedBox(width: 6),
                            Text(
                              '${widget.snap["experience"].toString()} yrs +',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
              onPressed: () async{
                setState(() {
                  _islooding=true;
                });

                await LawyerAuth().Booking(uid.toString(),username.toString(), widget.snap['uid'].toString(),widget.snap['username'] );

                showSnackBar("Booking Confirmed", context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MobileScreenLayout()));
                setState(() {
                  _islooding=false;
                });
                 },
              child:_islooding? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Text(
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