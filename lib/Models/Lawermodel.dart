import 'package:cloud_firestore/cloud_firestore.dart';

class Lawyer{
  final String email;
  final String uid;
  final String photoUrl;
  final  String username;
  final String mobile;
  final List booking;
  final int age;
  final String gender;
  final String address;
  final String license;
  final int experience;
  final String court;
  final bool valid;
  final String city;
  final String about;
  final String speci;

  const Lawyer({
    required  this.age,
    required this.gender,
    required  this.address,
    required  this.license,
    required  this.experience,
    required  this.court,
    required this.email,
    required  this.uid,
    required this.photoUrl,
    required this.username,
    required this.mobile,
    required this.booking,
    required this.valid,
    required this.about,
    required this.city,
    required this.speci
  });

  Map<String ,dynamic> toJson() =>{
    "age":age,
    "gender":gender,
    "address":address,
    "license":license,
    "experience":experience,
    "court":court,
    "username" :username,
    "uid": uid,
    "email":email,
    "photoUrl": photoUrl,
    "mobile": mobile,
    "booking" : [],
    "valid":false,
    "about":about,
    "city":city,
    "speci":speci,
  };
  static Lawyer fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String ,dynamic>;
    return Lawyer(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        username: snapshot['username'],
        mobile: snapshot['mobile'],
        booking: snapshot['booking'],
        age: snapshot['age'],
        address: snapshot['address'],
      license: snapshot['license'],
      experience: snapshot['experience'],
      court: snapshot['court'],
      gender: snapshot['gender'],
        valid: snapshot['valid'],
      about: snapshot['about'],
      city: snapshot['city'],
      speci: snapshot['speci']
    );
  }
}