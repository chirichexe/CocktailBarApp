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
      // Impostare la larghezza desiderata
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.7, // 70% della larghezza dello schermo
        height: MediaQuery.of(context).size.height *
            0.5, // Altezza fissa o percentuale
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset('assets/image.png'), // Immagine
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
                        //da cambiare
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      DeleteMagazzinoElementButton(
                          idMagazzino: idMag, idElemento: idEl),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(), // Aggiunge spazio flessibile tra il contenuto e il pulsante
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

class DeleteMagazzinoElementButton extends StatefulWidget {
  final String idMagazzino;
  final String idElemento;
  const DeleteMagazzinoElementButton(
      {super.key, required this.idMagazzino, required this.idElemento});

  @override
  State<DeleteMagazzinoElementButton> createState() =>
      _DeleteMagazzinoElementButtonState();
}

class _DeleteMagazzinoElementButtonState
    extends State<DeleteMagazzinoElementButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: () async {
        await ShouldDeleteDialog.showDeleteDialog(
          context,
          FirebaseFirestore.instance
              .collection('Magazzini')
              .doc(widget.idMagazzino)
              .collection('Elements')
              .doc(widget.idElemento),
        );
      },
    );
  }
}
