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
            //await _deleteDocumentWithSubcollections(documentReference);
            documentReference.delete();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  static Future<void> _deleteDocumentWithSubcollections(DocumentReference document) async {
    // Fetch all subcollections of the document
    var subcollectionIds = await _getSubcollectionIds(document);

    // Iterate through each subcollection and delete its documents
    for (var subcollectionId in subcollectionIds) {
      var subcollectionRef = document.collection(subcollectionId);
      await _deleteAllDocumentsInCollection(subcollectionRef);
    }

    // Delete the document itself
    await document.delete();
  }

  static Future<void> _deleteAllDocumentsInCollection(CollectionReference collection) async {
    var snapshot = await collection.get();
    for (var doc in snapshot.docs) {
      await _deleteDocumentWithSubcollections(doc.reference);
    }
  }

  static Future<List<String>> _getSubcollectionIds(DocumentReference document) async {
    // Fetch all subcollections of the document using a known list of subcollections or another method
    return ['Elements']; // Replace with actual subcollection IDs
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
