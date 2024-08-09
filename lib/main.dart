import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lawadvisor/Mob_nav.dart';
import 'package:lawadvisor/screens/loginscreen.dart';
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
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState== ConnectionState.active){
            if(snapshot.hasData){
              return const MobileScreenLayout();
            }else if(snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

