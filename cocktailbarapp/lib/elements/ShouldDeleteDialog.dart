import 'package:flutter/material.dart';

class ShouldDeleteDialog extends StatelessWidget {
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
            Navigator.of(context).pop(true); // Chiude il dialog e ritorna true
          },
        ),
      ],
    );
  }

  static Future<bool?> showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ShouldDeleteDialog();
      },
    );
  }
}
