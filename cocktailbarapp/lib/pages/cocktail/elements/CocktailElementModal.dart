import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialog.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/DeleteCocktailElementButton.dart';
import 'package:cocktailbarapp/pages/cocktail/elements/IngredientlList.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CocktailElementModal extends StatelessWidget {
  final String idElemento;

  CocktailElementModal({required this.idElemento});

  late CollectionReference ingredients = FirebaseFirestore.instance
      .collection('Cocktails')
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
          future: FirebaseFirestore.instance
              .collection('Cocktails')
              .doc(idElemento)
              .get(),
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
                  Text(data['name'] ?? 'Nome del cocktail',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(
                      'Metodo: ${data['method'] ?? 'Nessun metodo specificato'}'),
                  Text(
                      'Garnish: ${data['garnish'] ?? 'Nessun garnish specificato'}'),
                  Text('Ghiaccio: ${data['ice'] ?? true ? 'Si' : 'No'}'),
                  SizedBox(height: 20),
                  Text('Ingredienti:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  GFButton(
                    onPressed: () async {
                      bool? shouldDelete =
                          await ShouldDeleteDialog.showDeleteDialog(
                        context,
                        FirebaseFirestore.instance
                            .collection('Cocktails')
                            .doc(idElemento),
                      );

                      if (shouldDelete == true) {
                        Navigator.of(context).pop();
                      }
                    },
                    text: 'Delete', // Aggiungi il testo del pulsante
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
