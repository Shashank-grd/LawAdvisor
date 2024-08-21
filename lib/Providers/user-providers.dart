
import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/auth.dart';
import 'package:lawadvisor/Models/usermodel.dart';


class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethod _authMethod=AuthMethod();
  User get getUser =>_user!;
  Future<void> refreshUser() async{
    User user=await _authMethod.getUserDetails();
    _user=user;
    notifyListeners();
  }
}