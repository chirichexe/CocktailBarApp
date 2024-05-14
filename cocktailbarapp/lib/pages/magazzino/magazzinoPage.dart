import 'package:cocktailbarapp/pages/magazzino/elements/CreateMagazzinoModal.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/Magazzino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';

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
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                GFIconButton(
                  padding: const EdgeInsets.all(15.0),
                  icon: const Icon(Icons.plus_one),
                  onPressed: onPressedButton,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListaMagazzini(elencoMagazzini: _elementi),
          ),
        ],
      ),
    );
  }
}
