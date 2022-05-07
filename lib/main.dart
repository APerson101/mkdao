import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/LandingPage/landing_page.dart';
import 'package:mkdao/MainPage/mainpage.dart';
import 'package:mkdao/home/homeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: HomeView(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
