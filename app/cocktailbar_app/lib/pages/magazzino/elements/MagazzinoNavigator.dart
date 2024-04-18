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
/*
    for (int i = 0; i < 9; i++) {
      _elementi.add(new MagazzinoElement(
          idMagazzino: _id,
          idElemento: i,
          nome: "Gin${i} del magazzino ${_id}"));
    }*/

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

  void loadElementsFromFirebase() async {
    // Effettua una query al database per ottenere gli elementi del magazzino
    QuerySnapshot querySnapshot = await db
        .collection('MagazzinoElement')
        .where('idMagazzino', isEqualTo: _id)
        .get();

    setState(() {
      _elementi
          .clear(); // Svuota la lista prima di aggiungere gli elementi dal database
      querySnapshot.docs.forEach((doc) {
        // Itera sui documenti ottenuti dalla query
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Crea un nuovo oggetto MagazzinoElement utilizzando i dati ottenuti dal database
        _elementi.add(MagazzinoElement(
          idMagazzino: data['idMagazzino'],
          idElemento: data['idElemento'],
          nome: data['name'],
        ));
      });

      // Assicurati di inizializzare anche _filteredElementi
      _filteredElementi.addAll(_elementi);
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
