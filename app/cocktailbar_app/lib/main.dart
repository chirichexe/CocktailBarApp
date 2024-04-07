// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'pages/homepage/homePage.dart';
import 'pages/secondpage/secondPage.dart';
import 'pages/thirdpage/thirdPage.dart';
import 'pages/fourthpage/fourthPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDrawer(),
      routes: {
        '/second': (context) => createSecondPage(),
        '/third': (context) => createThirdPage(),
        '/fourth': (context) => createFourthPage(),
      },
    );
  }
}
