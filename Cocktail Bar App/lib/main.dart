import 'package:cocktailbarapp/global/MainDrawer.dart';
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
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/magazzino': (context) => MagazzinoPage(),
        '/cocktail': (context) => CocktailPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: const MainDrawer(
          initialIndex: 0,
          drawerTitle: "Cocktail App Bar",
          pageRoutes: {
            "/home": "Home",
            "/magazzino": "Magazzino",
            "/cocktail": "Cocktail",
          },
        ),
      body: Stack(
        children: [
          // Immagine di sfondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
