import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateCocktailModal extends StatelessWidget {

  CreateCocktailModal({super.key});

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerDescrizione = TextEditingController();

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
                      TextField(
                        controller: controllerNome,
                        decoration: const InputDecoration(
                          labelText: 'Nome elemento',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controllerDescrizione,
                        decoration: const InputDecoration(
                          labelText: 'Descizione',
                          border: OutlineInputBorder(),
                        ),
                        //da cambiare
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            try {
                              FirebaseFirestore.instance.collection('Cocktails')
                              .add(
                                {
                                'name': controllerNome.text,
                                'description': controllerDescrizione.text,
                                });
                              print('Dati inseriti con successo nel database Firebase.');
                            } catch (error) {
                              print(
                              'Errore durante l\'inserimento dei dati nel database Firebase: $error');
                            }
                            Navigator.of(context).pop();
                          },
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