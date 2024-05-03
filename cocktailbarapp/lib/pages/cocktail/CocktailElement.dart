import 'package:cocktailbarapp/pages/cocktail/CocktailElementModal.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CocktailElement extends StatefulWidget {
  final String nome;
  final String descrizione;
  final String idElemento;

  const CocktailElement({
    super.key,
    required this.nome,
    required this.descrizione,
    required this.idElemento,
  });


  @override
  State<CocktailElement> createState() => _CocktailElementState();
}

class _CocktailElementState extends State<CocktailElement> {
  final String _nome="";
  final String _descrizione="";
  final String _idElemento="";
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Funzione per aprire il modale
        _showModal(context);
      },
      child: GFCard(
        color: const Color.fromARGB(255, 26, 5, 146),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        title: GFListTile(
          titleText: _nome,
          color: GFColors.WHITE,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CocktailElementModal(
            nome: _nome,
            descrizione: _descrizione,
            idEl: _idElemento,
          );
        });
  }
}