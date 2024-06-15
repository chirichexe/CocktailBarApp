import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShouldDeleteDialog extends StatelessWidget {
  final DocumentReference documentReference;

  ShouldDeleteDialog({required this.documentReference});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Conferma Cancellazione',
                  style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
      content: const Text('Sei sicuro di voler cancellare questo elemento?',
                          style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
      actions: <Widget>[
        TextButton(
          child: const Text('No',
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Sì',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
          onPressed: () async {
            await documentReference.delete();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  static Future<bool?> showDeleteDialog(
      BuildContext context, DocumentReference documentReference) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ShouldDeleteDialog(documentReference: documentReference);
      },
    );
  }
}
