import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElementModal extends StatelessWidget {
  final String nome;
  final String descrizione;
  final String idMag;
  final String idEl;

  const MagazzinoElementModal({
    super.key,
    required this.nome,
    required this.descrizione,
    required this.idEl,
    required this.idMag,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        descrizione,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GFButton(
                  onPressed: () async {
                    bool? shouldDelete =
                        await ShouldDeleteDialog.showDeleteDialog(
                      context,
                      FirebaseFirestore.instance
                          .collection('Magazzini')
                          .doc(idMag)
                          .collection('Elements')
                          .doc(idEl),
                    );

                    if (shouldDelete == true) {
                      Navigator.of(context).pop();
                    }
                  },
                  text: 'Elimina',
                  color: Colors.redAccent,
                  icon: Icon(Icons.delete, color: Colors.white),
                  shape: GFButtonShape.pills,
                ),
                GFButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Chiudi',
                  color: Colors.blue,
                  shape: GFButtonShape.pills,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
