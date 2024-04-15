import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElementModal extends StatelessWidget {
  final String nome;
  final String descrizione;

  const MagazzinoElementModal(
      {Key? key, required this.nome, required this.descrizione})
      : super(key: key);

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
          child: Text('Chiudi'),
        ),
      ],
    );
  }
}
