import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbar_app/pages/magazzino/elements/MagazzinoElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoNavigator extends StatefulWidget {
  final int id;

  const MagazzinoNavigator({super.key, required this.id});

  @override
  State<MagazzinoNavigator> createState() => _MagazzinoNavigatorState();
}

class _MagazzinoNavigatorState extends State<MagazzinoNavigator> {
  int _id = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<MagazzinoElement> _elementi = [];
  List<MagazzinoElement> _filteredElementi = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _id = widget.id;

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
    // Aggiungi qui il codice per l'azione del pulsante
  }

  void loadElementsFromFirebase() {
    // Utilizza lo stream per ottenere gli aggiornamenti in tempo reale dal database
    db
        .collection('MagazzinoElement')
        .where('idMagazzino', isEqualTo: _id)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      setState(() {
        _elementi.clear();
        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          _elementi.add(MagazzinoElement(
            idMagazzino: data['idMagazzino'],
            idElemento: data['idElemento'],
            nome: data['name'],
          ));
        });

        // Assicurati di inizializzare anche _filteredElementi
        _filteredElementi.clear();
        _filteredElementi.addAll(_elementi);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magazzino con id: $_id"),
      ),
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
