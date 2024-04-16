// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbar_app/pages/magazzino/elements/Magazzino.dart';
import 'package:flutter/material.dart';

class MagazzinoPage extends StatefulWidget {
  @override
  State<MagazzinoPage> createState() => _MagazzinoState();
}

class _MagazzinoState extends State<MagazzinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: const Column(children: <Widget>[
        Expanded(
          child: ListaMagazzini(
            elencoMagazzini: [
              Magazzino(id: 1, nome: "Gin", descrizione: "Magazzino gin"),
              Magazzino(id: 2, nome: "Vodka", descrizione: "Magazzino vodka"),
              Magazzino(
                  id: 3, nome: "Garnish", descrizione: "Magazzino garnish"),
            ],
          ),
        ),
      ]),
    );
  }
}
