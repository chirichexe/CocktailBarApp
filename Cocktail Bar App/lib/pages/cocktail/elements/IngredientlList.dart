import 'package:cocktailbarapp/pages/cocktail/elements/IngredientItemShow.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocktailbarapp/pages/cocktail/classes/Ingredient.dart'; // Assicurati che il percorso del tuo file Ingredient.dart sia corretto

class IngredientList extends StatelessWidget {
  final CollectionReference ingredientsCollection;

  const IngredientList({Key? key, required this.ingredientsCollection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ingredientsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        }
        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot document = documents[index];
            final ingredient = Ingredient(
              name: document['name'] ?? '',
              qty: document['quantity'] ?? '',
            );
            return IngredientItem(ingredient: ingredient);
          },
        );
      },
    );
  }
}
