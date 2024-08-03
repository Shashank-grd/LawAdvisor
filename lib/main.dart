import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/Mob_nav.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color.fromRGBO(19, 28, 33,1),
          appBarTheme: const AppBarTheme(
              color: Color.fromRGBO(31,44,52,1)
          ),
      ),
      home: const MobileScreenLayout(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Text("Shashank"),
    );
  }
}
