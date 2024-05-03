import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/CreateElementModal.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/MagazzinoElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoNavigator extends StatefulWidget {
  final String id;

  const MagazzinoNavigator({super.key, required this.id});

  @override
  State<MagazzinoNavigator> createState() => _MagazzinoNavigatorState();
}

class _MagazzinoNavigatorState extends State<MagazzinoNavigator> {
  String idMagazzino = "";
  final TextEditingController _searchController = TextEditingController();
  final List<MagazzinoElement> _elementi = [];
  List<MagazzinoElement> _filteredElementi = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    idMagazzino = widget.id;

    loadElementsFromFirebase();

    _filteredElementi.addAll(_elementi);
    _searchController.addListener(() {
      filterElements();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterElements() {
    setState(() {
      _filteredElementi = _elementi
          .where((element) => element.nome
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void onPressedButton() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateElementModal(idMag: idMagazzino);
        });
  }

  void loadElementsFromFirebase() {
  // Ottieni la sottocollezione di elementi del magazzino
  db
    .collection('Magazzini')
    .doc(idMagazzino)
    .collection('Elements')
    .snapshots()
    .listen((elementiSnapshot) {
      setState(() {
        _elementi.clear();
        _filteredElementi.clear();
        for (var elementoDoc in elementiSnapshot.docs) {
          Map<String, dynamic> data = elementoDoc.data();
          _elementi.add(MagazzinoElement(
            idMagazzino: idMagazzino,
            idElemento: elementoDoc.id, // ID dell'elemento
            nome: data['name'],
            descrizione: data['description'],
          ));
        }
        _filteredElementi.addAll(_elementi);
      });
    });
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
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
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Cerca...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: _filteredElementi.map((element) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MagazzinoElement(
                    idMagazzino: element.idMagazzino,
                    idElemento: element.idElemento,
                    descrizione: element.descrizione,
                    nome: element.nome,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
