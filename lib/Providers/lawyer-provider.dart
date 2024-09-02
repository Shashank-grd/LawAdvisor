import 'package:flutter/material.dart';
import 'package:lawadvisor/Firebase/lawyer-auth.dart';
import 'package:lawadvisor/Models/Lawermodel.dart';


class LawyerProvider with ChangeNotifier{
  Lawyer? _lawyer;
  final LawyerAuth _lawyerMethod=LawyerAuth();
  Lawyer get getLawyer =>_lawyer!;
  Future<void> refreshLawyer() async{
    Lawyer lawyer=await _lawyerMethod.getLawyerDetails();
   _lawyer =lawyer;
    notifyListeners();
  }
}