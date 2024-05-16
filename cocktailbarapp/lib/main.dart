import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cocktailbarapp/global/MyDrawer.dart';
import 'pages/magazzino/page/MagazzinoPage.dart';
import 'pages/cocktail/CocktailPage.dart';
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
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.jpg'), // Imposta il percorso dell'immagine di sfondo
            fit: BoxFit.cover,
          ),
        ),
        child: MyDrawer(), // Contenuto della tua app
      ),
      routes: {
        '/magazzino': (context) => MagazzinoPage(),
        '/cocktail': (context) => CocktailPage(),
      },
    );
  }
}
