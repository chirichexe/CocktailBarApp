import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CreateCocktailModal.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CocktailElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class CocktailPage extends StatefulWidget {
  const CocktailPage({super.key});

  @override
  State<CocktailPage> createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<CocktailElement> _elementi = [];
  List<CocktailElement> _filteredElementi = [];

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
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
          return CreateCocktailModal();
        });
  }

  void loadElementsFromFirebase() {
    db.collection('Cocktails').snapshots().listen((elementiSnapshot) {
      setState(() {
        _elementi.clear();
        _filteredElementi.clear();
        for (var elementoDoc in elementiSnapshot.docs) {
          Map<String, dynamic> data = elementoDoc.data();
          _elementi.add(CocktailElement(
              idElemento: elementoDoc.id, // ID dell'elemento
              nome: data['name']));
        }
        _filteredElementi.addAll(_elementi);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cocktail Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent[100],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                FloatingActionButton(
              onPressed: onPressedButton,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              child: Icon(Icons.plus_one),
              elevation: 4,
            ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.blue[800]),
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
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10.0),
              children: _filteredElementi.map((element) {
                return Container(
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
                  child: CocktailElement(
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
