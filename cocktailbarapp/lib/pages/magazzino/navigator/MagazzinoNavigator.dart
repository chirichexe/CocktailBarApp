import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/magazzino/navigator/elements/CreateElementModal.dart';
import 'package:cocktailbarapp/pages/magazzino/navigator/elements/MagazzinoElement.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class MagazzinoNavigator extends StatefulWidget {
  final String id;
  final String nome;

  const MagazzinoNavigator({Key? key, required this.id, required this.nome})
      : super(key: key);

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
            idElemento: elementoDoc.id,
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
        foregroundColor: Colors.white,
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
                    style: GoogleFonts.roboto(
                        fontSize: 16, color: Colors.blue[800]),
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cerca...',
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 3;
                } else {
                  crossAxisCount = 2;
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _filteredElementi.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: AspectRatio(
                        aspectRatio: 1, // Quadrato
                        child: MagazzinoElement(
                          idMagazzino: _filteredElementi[index].idMagazzino,
                          idElemento: _filteredElementi[index].idElemento,
                          descrizione: _filteredElementi[index].descrizione,
                          nome: _filteredElementi[index].nome,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
