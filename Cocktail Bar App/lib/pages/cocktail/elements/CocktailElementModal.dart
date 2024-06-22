import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/elements/ShouldDeleteDialogCocktails.dart';
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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Cocktails')
              .doc(idElemento)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Errore: ${snapshot.error}',
                    style: TextStyle(color: Colors.redAccent)),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Text(
                  'Nessun cocktail trovato con l\'ID fornito.',
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'] ?? 'Nome del cocktail',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const SizedBox(height: 10),
                Text('Metodo: ${data['method'] ?? 'Nessun metodo specificato'}',
                    style: const TextStyle(color: Colors.blueGrey)),
                const SizedBox(height: 10),
                Text(
                    'Garnish: ${data['garnish'] ?? 'Nessun garnish specificato'}',
                    style: const TextStyle(color: Colors.blueGrey)),
                const SizedBox(height: 10),
                Text(
                    'Ghiaccio: ${data['ice'] ?? 'Nessun ghiaccio specificato'}',
                    style: const TextStyle(color: Colors.blueGrey)),
                const SizedBox(height: 10),
                Text(
                    'Bicchiere: ${data['glass'] ?? 'Nessun bicchiere specificato'}',
                    style: const TextStyle(color: Colors.blueGrey)),
                const SizedBox(height: 20),
                const Text('Ingredienti',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const SizedBox(height: 10),
                Expanded(
                  child: IngredientList(ingredientsCollection: ingredients),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Chiudi',
                          style: TextStyle(color: Colors.blueAccent)),
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
                      text: 'Delete',
                      color: Colors.redAccent,
                      icon: Icon(Icons.delete, color: Colors.white),
                      shape: GFButtonShape.pills,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
