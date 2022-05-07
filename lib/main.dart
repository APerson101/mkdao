import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/LandingPage/landing_page.dart';
import 'package:mkdao/MainPage/mainpage.dart';
import 'package:mkdao/home/homeview.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCQMF9mWDwsA9OGUJgH20VCS9jXcfpRgTw",
          authDomain: "mkdao-564b7.firebaseapp.com",
          databaseURL: "https://mkdao-564b7-default-rtdb.firebaseio.com",
          projectId: "mkdao-564b7",
          storageBucket: "mkdao-564b7.appspot.com",
          messagingSenderId: "918021967022",
          appId: "1:918021967022:web:cb2d3cbe7b1fe66a04b13f"));
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: LandingPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
