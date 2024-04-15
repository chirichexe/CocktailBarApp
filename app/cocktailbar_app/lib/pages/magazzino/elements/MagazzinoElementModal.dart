import 'package:flutter/material.dart';

class MagazzinoElementModal extends StatelessWidget {
  final String nome;
  final String descrizione;

  const MagazzinoElementModal(
      {super.key, required this.nome, required this.descrizione});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(nome),
      content: Text(descrizione),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Chiudi'),
        ),
      ],
    );
  }
}
