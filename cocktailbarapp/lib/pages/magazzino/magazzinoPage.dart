import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/CreateMagazzinoModal.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/Magazzino.dart';

class MagazzinoPage extends StatefulWidget {
  @override
  State<MagazzinoPage> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<MagazzinoPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final List<Magazzino> _elementi = [];

  @override
  void initState() {
    super.initState();
    loadElementsFromFirebase();
  }

  void loadElementsFromFirebase() {
    // Utilizza lo stream per ottenere gli aggiornamenti in tempo reale dal database
    db
        .collection('Magazzini')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<Magazzino> newElementi = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        newElementi.add(Magazzino(
          id: doc.id,
          nome: data['name'],
          descrizione: data['description'],
        ));
      }
      setState(() {
        _elementi.clear();
        _elementi.addAll(newElementi);
      });
    });
  }

  void onPressedButton() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateMagazzinoModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: ListaMagazzini(elencoMagazzini: _elementi),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: onPressedButton,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              child: Icon(Icons.plus_one),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }
}
