// ignore_for_file: use_key_in_widget_constructors
import 'package:cocktailbar_app/pages/magazzino/elements/ListaMagazzini.dart';
import 'package:cocktailbar_app/pages/magazzino/elements/magazzino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class createMagazzinoPage extends StatefulWidget {
  @override
  MagazzinoPage createState() => MagazzinoPage();
}

class MagazzinoPage extends State<createMagazzinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Magazzino'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListaMagazzini(
            elencoMagazzini: [
              Magazzino(id: 1, nome: "Gigiuo", descrizione: "Magazzino gin"),
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
