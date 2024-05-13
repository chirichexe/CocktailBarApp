import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/IngredientlList.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

// ignore: must_be_immutable

class CocktailElementModal extends StatelessWidget {
  final String idElemento;

  CocktailElementModal({required this.idElemento});

  late CollectionReference ingredients = FirebaseFirestore.instance.collection('Cocktails')
                                    .doc(idElemento)
                                    .collection('ingredients');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
       width: MediaQuery.of(context).size.width *
            0.8, // 70% della larghezza dello schermo
        height: MediaQuery.of(context).size.height *
            0.8, // Altezza fissa o percentuale
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
      future: FirebaseFirestore.instance.collection('Cocktails').doc(idElemento).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Indicatore di caricamento
          );
        }

        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Errore: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Container(
            alignment: Alignment.center,
            child: Text('Nessun cocktail trovato con l\'ID fornito.'),
          );
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['name'] ?? 'Nome del cocktail', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Metodo: ${data['method'] ?? 'Nessun metodo specificato'}'),
              Text('Garnish: ${data['garnish'] ?? 'Nessun garnish specificato'}'),
              Text('Ghiaccio: ${data['ice'] ?? false ? 'Si' : 'No'}'),
              SizedBox(height: 20),
              Text('Ingredienti:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Expanded(
                child: IngredientList(ingredientsCollection: ingredients),
              ),
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


/*return Dialog(
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
    );*/