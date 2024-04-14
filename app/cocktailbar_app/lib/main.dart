// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cocktailbar_app/pages/homepage/homePage.dart';
import 'pages/magazzino/magazzinoPage.dart';
import 'pages/cocktail/cocktailPage.dart';
import 'package:getwidget/getwidget.dart';

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
        '/magazzino': (context) => createMagazzinoPage(),
        '/cocktail': (context) => createCocktailPage(),
      },
    );
  }
}
