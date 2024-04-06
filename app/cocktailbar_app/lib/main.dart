// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'homePage.dart';
import 'secondPage.dart';
import 'thirdPage.dart';
import 'fourthPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/second': (context) => createSecondPage(),
        '/third': (context) => createThirdPage(),
        '/fourth': (context) => createFourthPage(),
      },
    );
  }
}



