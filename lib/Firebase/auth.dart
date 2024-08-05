import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/storage-method.dart';

import '../Models/usermodel.dart'as model;


class AuthMethod{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap= await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromsnap(snap);
  }
  //sign Up
  Future <String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String mobile,
    required Uint8List file,
  }) async {
    String res= "Some Error Occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || mobile.isNotEmpty  ){
        UserCredential cred=  await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);


        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        //add user to database

        model.User user= model.User(email: email, uid: cred.user!.uid, photoUrl: photoUrl, username: username, mobile: mobile, booking: []);
        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);

        res= "success";
      }
    }
    catch(err){
      res= err.toString();
    }
    return res;
  }

  //login user
  Future <String > loginUser({
    required String email,
    required String password
  }) async {
    String res='Some error happened';
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res= "success";
      }else{
        res ="please enter all the fields";
      }
    }catch(err){
      res= err.toString();
    }
    return res;
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}