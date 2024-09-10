import 'package:flutter/material.dart';
import 'package:lawadvisor/screens/home.dart';
import 'package:lawadvisor/screens/profilescreen.dart';
import 'package:lawadvisor/screens/search-screen.dart';


List<Widget> homeScreenItems = [
  HomeScreen(),
  SearchScreen(),
  Center(child: Text("Chatbot has also been created, all that remains is to connect the app with Chatbot, and the Jupyter file has also been attached.",
  style: TextStyle(
    wordSpacing: 5,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),)),
  ProfileScreen()
];

