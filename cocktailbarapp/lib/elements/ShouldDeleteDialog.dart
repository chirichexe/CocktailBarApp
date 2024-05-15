import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShouldDeleteDialog extends StatelessWidget {
  final DocumentReference documentReference;

  ShouldDeleteDialog({required this.documentReference});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Conferma Cancellazione'),
      content: Text('Sei sicuro di voler cancellare questo elemento?'),
      actions: <Widget>[
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Sì'),
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
