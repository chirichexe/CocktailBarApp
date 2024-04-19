import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateElementModal extends StatelessWidget {
  final int idMag;

  const CreateElementModal({super.key, required this.idMag});

  void onPressedButton() async {
    try {
      FirebaseFirestore.instance.collection('MagazzinoElement').add({
        'idMagazzino': idMag,
        'idElemento': 12,
        'name': "testrobo",
        'descrizione': "test",
      });
      print('Dati inseriti con successo nel database Firebase.');
    } catch (error) {
      print(
          'Errore durante l\'inserimento dei dati nel database Firebase: $error');
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
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset('assets/image.png'), // Immagine
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Crea un elemento",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Nome elemento',
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Descizione',
                          border: OutlineInputBorder(),
                        ),
                        //da cambiare
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: onPressedButton,
                          child: const Text('Aggiungi'))
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
