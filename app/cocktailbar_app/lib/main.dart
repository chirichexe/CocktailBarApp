// ignore_for_file: use_key_in_widget_constructors

import 'package:cocktailbar_app/pages/firebase/firebasePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cocktailbar_app/pages/homepage/homePage.dart';
import 'pages/magazzino/magazzinoPage.dart';
import 'pages/cocktail/cocktailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Firebase.apps.isNotEmpty) {
    runApp(MyApp());
    print(Firebase.apps);
    FirebaseFirestore db = FirebaseFirestore.instance;
    final user = <String, dynamic>{
  "first": "Ada",
  "last": "Lovelace",
  "born": 1815
};

// Add a new document with a generated ID
    final cocks = await db.collection("cocktails").get();
    print("noveoknvenoeoneon ${cocks.docs}");
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
        '/database': (context) => MyFirebase(),
      },
    );
  }
}
