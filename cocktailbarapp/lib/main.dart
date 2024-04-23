import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cocktailbarapp/pages/homepage/homePage.dart';
import 'pages/magazzino/magazzinoPage.dart';
import 'pages/cocktail/cocktailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Firebase.apps.isNotEmpty) {
    runApp(MyApp());
    FirebaseFirestore db = FirebaseFirestore.instance;
  } else {
    print('Error: Firebase initialization failed');
  }
}

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
        '/magazzino': (context) => MagazzinoPage(),
        '/cocktail': (context) => CocktailPage(),
      },
    );
  }
}