import 'package:cocktailbar_app/pages/magazzino/elements/MagazzinoElementModal.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElement extends StatelessWidget {
  final String nome;
  final int idMagazzino;
  final int idElemento;

  const MagazzinoElement({
    super.key,
    required this.nome,
    required this.idMagazzino,
    required this.idElemento,
  });

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
          titleText: nome,
          color: GFColors.WHITE,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MagazzinoElementModal(nome: nome, descrizione: "descrizione");
        });
  }
}
