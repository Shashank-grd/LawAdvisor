import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/auth.dart';
import 'package:lawadvisor/screens/booking-history.dart';
import 'package:lawadvisor/screens/help-sup.dart';
import 'package:lawadvisor/screens/loginscreen.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String username="";
  String email='';
  String photo="";
  String usid="";
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
      email=(snap.data() as Map<String,dynamic>)['email'];
      photo=(snap.data() as Map<String,dynamic>)['photoUrl'];
      usid=(snap.data() as Map<String,dynamic>)['uid'];
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(photo),
            ),
            SizedBox(height: 20),
            Text(
              '${username}',
              style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${email}',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.white.withOpacity(0.2), // 30% opacity
              thickness: 1,
            ),
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(Icons.privacy_tip, 'Privacy', () {}),
                  SizedBox(height: 15,),
                  buildMenuItem(Icons.history, 'Booking History', () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookingScreen()));
                  }),
                  SizedBox(height: 15,),
                  buildMenuItem(Icons.help, 'Help & Support', () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContactDetailsScreen()));
                  }),
                  SizedBox(height: 15,),
                  buildMenuItem(Icons.person_add, 'Invite a Friend', () async{
                    try {
                     await Share.share('thank you');
                    }catch(e){
                      print(e.toString());
                    }
                    }),
                  SizedBox(height: 15,),
                  buildMenuItem(Icons.logout, 'Logout', () async{
                    await AuthMethod().signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onClicked) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0), // Padding inside the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        color: Colors.black, // Background color of the container
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onClicked,
      ),
    );
  }
}