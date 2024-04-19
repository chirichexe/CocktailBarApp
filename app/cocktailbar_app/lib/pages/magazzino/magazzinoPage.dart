import 'package:cocktailbar_app/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbar_app/pages/magazzino/elements/Magazzino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      setState(() {
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          _elementi.add(Magazzino(
            id: data['id'],
            nome: data['name'],
            descrizione: data['description'],
          ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListaMagazzini(elencoMagazzini: _elementi),
        ),
      ]),
    );
  }
}
