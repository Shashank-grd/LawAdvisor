import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lawadvisor/Firebase/storage-method.dart';
import 'package:lawadvisor/Models/Lawermodel.dart';
import 'package:uuid/uuid.dart';

class LawyerAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Lawyer> getLawyerDetails() async {
    User currentLawyer = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('lawyer').doc(currentLawyer.uid).get();
    return Lawyer.fromsnap(snap);
  }

  //Sign up for lawyer
  Future<String> signUpLawyer(
      {required String email,
      required String password,
      required String username,
      required String mobile,
      required Uint8List file,
      required int age,
      required String gender,
      required String address,
      required String license,
      required String court,
      required int experience,
      required String about,
      required String city,
      required String speci}) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          mobile.isNotEmpty &&
          age > 0 &&
          gender.isNotEmpty &&
          address.isNotEmpty &&
          license.isNotEmpty &&
          court.isNotEmpty &&
          city.isNotEmpty &&
          about.isNotEmpty &&
          speci.isNotEmpty &&
          experience >= 0) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('LawyerProfilePic', file, false);
        Lawyer lawyer = Lawyer(
            age: age,
            gender: gender,
            address: address,
            license: license,
            experience: experience,
            court: court,
            email: email,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            username: username,
            mobile: mobile,
            booking: [],
            valid: false,
            about: about,
            city: city,
            speci: speci);
        await _firestore.collection('Lawyers').doc(cred.user!.uid).set(
              lawyer.toJson(),
            );
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login for Lawyer
  Future<String> loginLawyer(
      {required String email, required String password}) async {
    String res = 'Some error happened';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOutLawyer() async {
    await _auth.signOut();
  }


  Future<void> Booking( String userId,String userName,String lawyerId,String lawyerName ) async{
    try{
        String BookingId=const Uuid().v1();
        await _firestore.collection('Booking').doc(BookingId).set(
            {
              'BookingId': BookingId,
              'userName': userName,
              'userId': userId,
              'lawyerId': lawyerId,
              'lawyerName': lawyerName,
              'datePublished': DateTime.now(),
            }
        );

    }catch(e){
      print(e.toString());
    }
  }
}
