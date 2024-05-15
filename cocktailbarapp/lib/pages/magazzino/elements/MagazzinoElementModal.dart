import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialog.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MagazzinoElementModal extends StatelessWidget {
  final String nome;
  final String descrizione;
  final String idMag;
  final String idEl;

  const MagazzinoElementModal(
      {super.key,
      required this.nome,
      required this.descrizione,
      required this.idEl,
      required this.idMag});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset('assets/image.png'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        descrizione,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                        text: 'Delete', // Aggiungi il testo del pulsante
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Chiudi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
