import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final  String username;
  final String mobile;
  final List booking;

  const User({
    required this.email,
    required  this.uid,
    required this.photoUrl,
    required this.username,
    required this.mobile,
    required this.booking,
  });

  Map<String ,dynamic> toJson() =>{
    "username" :username,
    "uid": uid,
    "email":email,
    "photoUrl": photoUrl,
    "mobile": mobile,
    "booking" : [],

  };
  static User fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String ,dynamic>;
    return User(email: snapshot['email'], uid: snapshot['uid'], photoUrl: snapshot['photoUrl'], username: snapshot['username'], mobile: snapshot['mobile'], booking: snapshot['booking']);
  }
}