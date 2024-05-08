import 'package:cocktailbarapp/pages/cocktail/elements/CocktailElementModal.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CocktailElement extends StatefulWidget {
  final String idElemento;
  final String nome;

  const CocktailElement(
      {super.key, required this.idElemento, required this.nome});

  @override
  State<CocktailElement> createState() => _CocktailElementState();
}

class _CocktailElementState extends State<CocktailElement> {
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
          titleText: widget.nome,
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
            idElemento: widget.idElemento,
          );
        });
  }
}
