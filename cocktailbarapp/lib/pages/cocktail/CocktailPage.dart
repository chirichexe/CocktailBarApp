import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CreateCocktailModal.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/CocktailElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

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
    // Ottieni la sottocollezione di elementi del magazzino
    db.collection('Cocktails').snapshots().listen((elementiSnapshot) {
      setState(() {
        _elementi.clear();
        _filteredElementi.clear();
        for (var elementoDoc in elementiSnapshot.docs) {
          Map<String, dynamic> data = elementoDoc.data();

          // Effettua il casting esplicito degli ingredienti a List<String>
          List<String> ingredienti = List<String>.from(data['ingredients']);

          _elementi.add(CocktailElement(
            idElemento: elementoDoc.id, // ID dell'elemento
            nome: data['name'],
            descrizione: data['description'],
            ingredienti: ingredienti, // Usa la lista di stringhe castata
          ));
        }
        _filteredElementi.addAll(_elementi);
      });
    });
  }
//List.from(data['ingredients'])

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
                  child: CocktailElement(
                      idElemento: element.idElemento,
                      descrizione: element.descrizione,
                      nome: element.nome,
                      ingredienti: element.ingredienti),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
