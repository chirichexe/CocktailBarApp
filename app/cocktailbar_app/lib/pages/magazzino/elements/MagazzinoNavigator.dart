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
  final List<MagazzinoElement> _elementi = [
    const MagazzinoElement(idMagazzino: 1, idElemento: 2, nome: "Gin"),
    const MagazzinoElement(idMagazzino: 2, idElemento: 3, nome: "Test"),
    const MagazzinoElement(idMagazzino: 3, idElemento: 4, nome: "Ok"),
    const MagazzinoElement(idMagazzino: 1, idElemento: 2, nome: "Okok"),
    const MagazzinoElement(idMagazzino: 2, idElemento: 3, nome: "pale"),
    const MagazzinoElement(idMagazzino: 3, idElemento: 4, nome: "dscs"),
    const MagazzinoElement(idMagazzino: 1, idElemento: 2, nome: "sdvsd"),
    const MagazzinoElement(idMagazzino: 2, idElemento: 3, nome: "dsvs"),
    const MagazzinoElement(idMagazzino: 3, idElemento: 4, nome: "sdvsd"),
    const MagazzinoElement(idMagazzino: 1, idElemento: 2, nome: "sdvsdv"),
    const MagazzinoElement(idMagazzino: 2, idElemento: 3, nome: "qwrfv"),
    const MagazzinoElement(idMagazzino: 3, idElemento: 4, nome: "wevsfd"),

    // Aggiungi gli altri elementi dal database qui
  ];
  List<MagazzinoElement> _filteredElementi = [];

  @override
  void initState() {
    super.initState();
    _id = widget.id;
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
