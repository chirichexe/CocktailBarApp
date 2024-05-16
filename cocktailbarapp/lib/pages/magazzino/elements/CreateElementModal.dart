import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateElementModal extends StatelessWidget {
  final String idMag;

  CreateElementModal({Key? key, required this.idMag}) : super(key: key);

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerDescrizione = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Larghezza del 80% dello schermo
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crea un elemento del magazzino",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controllerNome,
                decoration: InputDecoration(
                  labelText: 'Nome elemento',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controllerDescrizione,
                decoration: InputDecoration(
                  labelText: 'Descrizione',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseFirestore.instance
                        .collection('Magazzini')
                        .doc(idMag)
                        .collection('Elements')
                        .add({
                      'name': controllerNome.text,
                      'description': controllerDescrizione.text,
                    });
                    print(
                        'Dati inseriti con successo nel database Firebase.');
                  } catch (error) {
                    print(
                        'Errore durante l\'inserimento dei dati nel database Firebase: $error');
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Aggiungi'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Chiudi'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
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
