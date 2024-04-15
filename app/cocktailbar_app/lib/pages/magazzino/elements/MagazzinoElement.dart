import "package:cocktailbar_app/pages/magazzino/elements/magazzinoNavigator.dart";
import "package:flutter/material.dart";
import "package:getwidget/getwidget.dart";
import 'package:google_fonts/google_fonts.dart';

class MagazzinoElement extends StatefulWidget {
  final String nome;
  final int idMagazzino;
  final int idElemento;

  const MagazzinoElement(
      {super.key,
      required this.idMagazzino,
      required this.idElemento,
      required this.nome});

  @override
  State<MagazzinoElement> createState() => _MagazzinoElementState();
}

class _MagazzinoElementState extends State<MagazzinoElement> {
  String _nome = "";
  int _idMagazzino = 0;
  int _idElemento = 0;

  String _descrizione = ""; //La prenderà dal database

  @override
  void initState() {
    super.initState();
    _nome = widget.nome;
    _idMagazzino = widget.idMagazzino;
    _idElemento = widget.idElemento;
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
        color: Color.fromARGB(255, 26, 5, 146),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        title: GFListTile(
          titleText: _nome,
          color: GFColors.WHITE,
        ));
  }
}
