import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateMagazzinoModal extends StatelessWidget {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerDescrizione = TextEditingController();

  CreateMagazzinoModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Crea un Magazzino",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: controllerNome,
                          decoration: InputDecoration(
                            labelText: 'Nome Magazzino',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controllerDescrizione,
                          decoration: InputDecoration(
                            labelText: 'Descrizione Magazzino',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            try {
                              FirebaseFirestore.instance
                                  .collection('Magazzini')
                                  .add({
                                'name': controllerNome.text,
                                'description': controllerDescrizione.text,
                              });
                              print('Dati inseriti con successo nel database Firebase.');
                            } catch (error) {
                              print('Errore durante l\'inserimento dei dati nel database Firebase: $error');
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Aggiungi'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Chiudi'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
