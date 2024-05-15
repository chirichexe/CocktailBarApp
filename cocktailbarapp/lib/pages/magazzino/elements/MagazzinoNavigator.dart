import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/CreateElementModal.dart';
import 'package:cocktailbarapp/pages/magazzino/elements/MagazzinoElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class MagazzinoNavigator extends StatefulWidget {
  final String id;
  final String nome;

  const MagazzinoNavigator({Key? key, required this.id, required this.nome}) : super(key: key);

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
          .where((element) => element.nome.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void onPressedButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateElementModal(idMag: idMagazzino);
      },
    );
  }

  void loadElementsFromFirebase() {
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
      appBar: AppBar(
        title: Text('Magazzino ${widget.nome}'),
        backgroundColor: Colors.blueAccent[100],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                GFIconButton(
                  padding: const EdgeInsets.all(15.0),
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: onPressedButton,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.white70),
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cerca...',
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(5.0),
              children: _filteredElementi.map((element) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: MagazzinoElement(
                      idMagazzino: element.idMagazzino,
                      idElemento: element.idElemento,
                      descrizione: element.descrizione,
                      nome: element.nome,
                    ),
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

