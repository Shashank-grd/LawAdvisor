import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/screens/lawyer-detail.dart';
import 'package:lawadvisor/utils/utils.dart';

class LawyerCard extends StatefulWidget {
  final snap;
  const LawyerCard({Key? key,required this.snap}) : super(key: key);

  @override
  _LawyerCardState createState() => _LawyerCardState();
}

class _LawyerCardState extends State<LawyerCard> {
var userData={};

  getData() async{
    try{
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
    }catch(e){
      showSnackBar(e.toString(), context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LawyerDetailScreen(snap: widget.snap)));
      },
      child: Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                   widget.snap["photoUrl"]
                  ,  height: 100,
                    width: 100,
                    fit: BoxFit.cover,
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
                          fontSize: 16,
                          color: Colors.grey
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
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
                           ' ${widget.snap["court"]} court',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
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
    );
  }
}
