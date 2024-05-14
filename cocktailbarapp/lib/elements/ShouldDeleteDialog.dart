import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa il pacchetto necessario

class ShouldDeleteDialog extends StatelessWidget {
  final DocumentReference
      documentReference; // Aggiungi il campo per DocumentReference

  ShouldDeleteDialog(
      {required this.documentReference}); // Aggiungi il costruttore

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Conferma Cancellazione'),
      content: Text('Sei sicuro di voler cancellare questo elemento?'),
      actions: <Widget>[
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Chiude il dialog e ritorna false
          },
        ),
        TextButton(
          child: Text('Sì'),
          onPressed: () {
            // Qui puoi fare qualcosa con documentReference
            Navigator.of(context).pop(true); // Chiude il dialog e ritorna true
          },
        ),
      ],
    );
  }

  static Future<void> showDeleteDialog(
      BuildContext context, DocumentReference documentReference) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ShouldDeleteDialog(documentReference: documentReference);
      },
    );
  }
}
