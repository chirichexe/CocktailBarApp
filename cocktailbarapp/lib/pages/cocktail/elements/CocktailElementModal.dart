import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

// ignore: must_be_immutable
class CocktailElementModal extends StatelessWidget {
  final String idElemento;
  CocktailElementModal({super.key, required this.idElemento});

  final FirebaseFirestore db = FirebaseFirestore.instance;
  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
       width: MediaQuery.of(context).size.width *
            0.7, // 70% della larghezza dello schermo
        height: MediaQuery.of(context).size.height *
            0.5, // Altezza fissa o percentuale
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<DocumentSnapshot>(
        future: db.collection('Cocktails').doc(idElemento).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Errore: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('Nessun dato trovato');
          }
          // Estrai i dati dallo snapshot e costruisci l'interfaccia utente
          final Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
          if(data!=null) {
          return Container(
            // Resto del codice per la finestra di dialogo...
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
                            data['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            data['garnish'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            data['method'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "ghiaccio: ${data['ice']}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          //INSERIRE LISTA INGREDIENTI MODIFICABILE
                          //oggetto per mostrare ingredienti
                          DeleteCocktailElementButton(idElemento: idElemento),
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
          );
          } else {
            print("collezione non trovata");
            return Container();
          }
        },
      ),
      ),
    );
  }
}

class DeleteCocktailElementButton extends StatefulWidget {
  final String idElemento;
  const DeleteCocktailElementButton({super.key, required this.idElemento});

  @override
  State<DeleteCocktailElementButton> createState() =>
      _DeleteCocktailElementButtonState();
}

class _DeleteCocktailElementButtonState
    extends State<DeleteCocktailElementButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: () async {
        try {
          // Esegui una query per trovare il documento che corrisponde alle condizioni specificate
          await FirebaseFirestore.instance
              .collection('Cocktails')
              .doc(widget.idElemento)
              .delete();

          // Se esiste un documento che corrisponde alle condizioni, elimina il documento
        } catch (error) {
          print('Errore durante l\'eliminazione dell\'elemento: $error');
        }
        Navigator.of(context).pop();
      },
      color: Colors.purple,
      text: 'Cancella Elemento',
      textColor: Colors.white,
    );
  }
}
