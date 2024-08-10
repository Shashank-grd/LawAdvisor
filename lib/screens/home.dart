import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lawadvisor/screens/Lawyers-displaycard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username="";
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/appbarlawadv.png',
          height: 180,
          width: 200,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello  ${username},',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),

                Text("Let's help you find a Lawyer",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 8,),
                Divider(
                  color: Colors.white.withOpacity(0.2), // 30% opacity
                  thickness: 1, // Thickness of the line
                ),
                SizedBox(height: 15,),
                Text("Top Lawyer ",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Lawyers').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      LawyerCard(snap: snapshot.data!.docs[index].data()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
