import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  void onPressedDelete() async {
    try {
      // Esegui una query per trovare il documento che corrisponde alle condizioni specificate
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('MagazzinoElement')
          .where('idMagazzino', isEqualTo: idMag)
          .get();

      // Se esiste un documento che corrisponde alle condizioni, elimina il documento
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        print('Elemento eliminato con successo.');
      } else {
        print('Nessun documento corrispondente alle condizioni trovato.');
      }
    } catch (error) {
      print('Errore durante l\'eliminazione dell\'elemento: $error');
    }
  }

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
                      IconButton(
                          onPressed: onPressedDelete, icon: Icon(Icons.delete))
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
