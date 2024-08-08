import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/screens/Lawyers-displaycard.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Image.asset('assets/appbarlawadv.png'
          ,height: 180,
          width: 200,
        ),
      ),
     body:
     StreamBuilder(
       stream: FirebaseFirestore.instance.collection('Lawyers').snapshots(),
     builder: (context, AsyncSnapshot<QuerySnapshot<Map<String ,dynamic>>> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    return ListView.builder(
    itemCount : snapshot.data!.docs.length,
    itemBuilder: (context, index) =>  LawyerCard(
        snap: snapshot.data!.docs[index].data()
    ),
    );
    },
     ),
    );
  }
}
