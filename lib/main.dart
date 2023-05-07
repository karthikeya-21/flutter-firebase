import 'package:flutter/material.dart';
import 'package:firebase_demo/screens/loginscreen.dart';
import 'package:firebase_demo/screens/registerscreen.dart';
import 'package:firebase_demo/screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => loginscreen(),
        'register': (context) => registerscreen(),
        'welcome': (context) => welcomescreen()
      },
    ),
  );
}
